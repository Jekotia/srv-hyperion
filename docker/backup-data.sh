#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}" || exit 1
source .env

#-> BEGIN CONFIG <-#
outputDir="${_HYPERION_BACKUPS}"
sourceDir="${_HYPERION_DATA}"
datetime="$(date +%Y-%m-%d_%H-%M-%S)"
#->  END CONFIG  <-#

mkdir -p "$outputDir"

du -sh \
    --exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Cache" \
	--exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Media" \
	--exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Metadata" \
	--exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Logs" \
    ${sourceDir}/*
    #${sourceDir}/plex/config/Library/Application\ Support/Plex\ Media\ Server/*

docker-compose down

tar \
    -czf "${outputDir}/${datetime}.tar.gz" \
    --same-owner \
    --preserve-permissions \
    --exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Cache" \
	--exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Media" \
	--exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Metadata" \
	--exclude "${_HYPERION_DATA}/plex/config/Library/Application\ Support/Plex\ Media\ Server/Logs" \
    "${sourceDir}"

# while [ -e $exclusion_file ] ; do
# 	rm -f $exclusion_file
# done
# touch $exclusion_file

# for exclusion in "${exclusions[@]}" ; do
# 	echo $exclusion >> $exclusion_file
# done


#du -sh --exclude-from="$exclusion_file"  $_DATA/*

# echo "-------"
# tar \
# 	-cf "${target}" \
# 	--same-owner \
# 	--preserve-permissions \
# 	--exclude-tag="$exclusion_file" \
# 	"${source}"
