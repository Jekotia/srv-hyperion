function backup_plex() {
	local source="$_PLEX_DATA"
	local running="false"
	echo

	#-> check if plex is running
	if systemctl status plexmediaserver --no-pager > /dev/null ; then
		local running="true"

		#-> stop service if running
		echo "Stopping plexmediaserver"
		systemctl stop plexmediaserver
	fi

	#du -sh --exclude-from="$exclusion_file"  $_DATA/*
	du -sh \
		--exclude="$_PLEX_DATA/Application\ Support/Cache" \
		--exclude="$_PLEX_DATA/Application\ Support/Media" \
		--exclude="$_PLEX_DATA/Application\ Support/Metadata" \
		$source

	#-> backup plex data
	tar \
		-cf "${outputDir}/plex.tar" \
		$tar_args \
		--exclude $_PLEX_DATA/Application\ Support/Cache \
		--exclude $_PLEX_DATA/Application\ Support/Media \
		--exclude $_PLEX_DATA/Application\ Support/Metadata \
		"${source}"

	#-> if plex was running at start, start it
	if [[ "$running" == "true" ]] ; then
		echo "Starting plexmediaserver"
		systemctl start plexmediaserver
	fi
}