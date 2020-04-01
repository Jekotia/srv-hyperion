#! /bin/bash
outputDir="$_ROOT/backup"
# declare -a exclusions=(
# 	"$_DATA/.OSMC"
# 	"$_DATA/torrents"
# 	"$_PLEX_DATA/Application Support/Cache"
# 	"$_PLEX_DATA/Application Support/Media"
# 	"$_PLEX_DATA/Application Support/Metadata"
# 	"${_MULTIMEDIA}"
# )
#-> END CONFIG

datetime="$(date +%Y-%m-%d_%H-%M-%S)"
outputDir="$outputDir/data/${datetime}"
mkdir -p $outputDir

tar_args="--same-owner --preserve-permissions"

#source="${_DATA}"
#exclusion_file="$_ROOT/data-backup.exclusions.list"

source $_ROOT/functions/backups/init.sh

# while [ -e $exclusion_file ] ; do
# 	rm -f $exclusion_file
# done
# touch $exclusion_file

# for exclusion in "${exclusions[@]}" ; do
# 	echo $exclusion >> $exclusion_file
# done


#du -sh --exclude-from="$exclusion_file"  $_DATA/*

backup_jackett
backup_plex
backup_qbittorrent
backup_radarr
backup_sonarr


# echo "-------"
# tar \
# 	-cf "${target}" \
# 	--same-owner \
# 	--preserve-permissions \
# 	--exclude-tag="$excludion_file" \
# 	"${source}"
