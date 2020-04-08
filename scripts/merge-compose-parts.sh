#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

partsDir="${DIR}/../compose-parts"

output_file="$DIR/../docker-compose.yml"

declare -a compose_files=(
	#-> CORE
		"organizr.yml"
		"plex.yml"
		"ombi.yml"
	#-> PVR
		"sonarr.yml"
		"radarr.yml"
		#"lidarr.yml"
		#"lazylibrarian.yml"
	#-> DOWNLOAD
		"qbittorrent.yml"
	#-> SEARCH
		"jackett.yml"
	#-> OTHER
		#"ubooquity.yml"
		"tautulli.yml"
)

touch "${output_file}"

cat "${partsDir}/header.production.yml" > ${output_file}
#cat <<EOF > "${output_file}"
#version: '3.7'
#services:
#EOF

#for file in "${compose_files[@]}" ; do
for file in "${partsDir}"/*/*.production.yml ; do
	grep -vE -- "^version:.*$|^services:.*$" "${file}" | sed 's/^#-> https/  #-> https/' >> "${output_file}"
done

cat "${partsDir}/footer.production.yml" >> ${output_file}
