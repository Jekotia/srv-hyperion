#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}/.." || exit 1
source .env

#-> BEGIN CONFIG <-#
outputDir="${_HYPERION_STORAGE_BACKUPS}"
sourceDir="${_HYPERION_STORAGE_DATA}"
datetime="$(date +%Y-%m-%d_%H-%M-%S)"
outputArchive="${outputDir}/${datetime}.tar"
#->  END CONFIG  <-#

case $1 in
	--debug)
		debug="true" ; shift 1
	;;
esac

mkdir -p "$outputDir"

du -sh \
	--exclude "${_HYPERION_STORAGE_DATA}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Cache" \
	--exclude "${_HYPERION_STORAGE_DATA}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Media" \
	--exclude "${_HYPERION_STORAGE_DATA}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Metadata" \
	--exclude "${_HYPERION_STORAGE_DATA}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Logs" \
	${sourceDir}/*
	#${sourceDir}/plex/config/Library/Application\ Support/Plex\ Media\ Server/*

echo "Creating empty base archive: ${outputArchive}"
tar -cf "${outputArchive}" -T /dev/null
#tar -czf "${outputArchive}" -T /dev/null

for dir in "${sourceDir}"/*/ ; do
	#-> ITERATION SETUP
	pause="false"
	service="$(basename $dir)"

	echo "Commencing backup for ${dir}"
if [[ "$debug" == "true" ]] ; then  read -p "  Press enter to continue" ;  fi
	if docker-compose ps --services --filter status=paused | grep "${service}" > /dev/null ; then
		echo "  Service already paused, will not change it: $service"
	elif docker-compose ps --services --filter status=running | grep "${service}" > /dev/null ; then
		echo "  Will pause running service: $service"
		if [[ "$debug" == "true" ]] ; then  read -p "  Press enter to continue" ;  fi

		if (set -o pipefail && docker-compose pause "${service}" | sed 's/^/  /') ; then
			pause="true"
		else
			pause="fail"
		fi
	elif docker-compose ps --services --filter status=restarting | grep "^${service}$" > /dev/null ; then
		echo "  Will pause restarting service: $service"
		if [[ "$debug" == "true" ]] ; then  read -p "  Press enter to continue" ;  fi

		if (set -o pipefail && docker-compose pause "${service}" | sed 's/^/  /') ; then
			pause="true"
		else
			pause="fail"
		fi
	else
		pause="false"
	fi

	if [[ "$pause" == "fail" ]] ; then
		echo "  Backup for '${dir}' has been skipped due to an error when trying to pause '${service}'"
	else
		echo "  Backing up ${dir}"
		if [[ "$debug" == "true" ]] ; then  read -p "  Press enter to continue" ;  fi
			# --gzip \
		tar \
			--append \
			--same-owner \
			--preserve-permissions \
			--file "${outputArchive}" \
			--exclude "${sourceDir}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Cache" \
			--exclude "${sourceDir}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Media" \
			--exclude "${sourceDir}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Metadata" \
			--exclude "${sourceDir}/plexms/config/Library/Application\ Support/Plex\ Media\ Server/Logs" \
			"${dir}" \
				| sed 's/^/  /'

		if [[ "${pause}" == "true" ]] ; then
			echo "  Unpausing service: ${service}"
			if [[ "$debug" == "true" ]] ; then  read -p "  Press enter to continue" ;  fi
			docker-compose unpause "${service}" | sed 's/^/  /'
		fi
	fi
	echo
done

echo "Compressing backup"
if [[ "$debug" == "true" ]] ; then  read -p "  Press enter to continue" ;  fi

tar \
	--verbose \
	--create \
	--gzip \
	--same-owner \
	--preserve-permissions \
	--file "${outputArchive}.gz" \
	"${outputArchive}"

rm -fv ${outputArchive}
