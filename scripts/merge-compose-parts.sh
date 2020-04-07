#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

partsDir="${DIR}/../docker-compose-parts"

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

cat <<EOF > "${output_file}"
version: "3.3"
services:
EOF

for file in "${compose_files[@]}" ; do
	grep -vE -- "^version:.*$|^services:.*$" "${partsDir}/${file}" | sed 's/^#-> https/  #-> https/' >> "${output_file}"
done
