function backup_sonarr() {
	local source="$_SONARR_DATA"
	local running="false"
	echo
#du -sh --exclude-from="$exclusion_file"  $_DATA/*

	#-> check if sonarr is running
	if systemctl status sonarr --no-pager > /dev/null ; then
		local running="true"

		#-> stop service if running
		echo "Stopping sonarr"
		systemctl stop sonarr
	fi

	du -sh $source

	#-> backup sonarr data
	tar \
		-cf "${outputDir}/sonarr.tar" \
		$tar_args \
		"${source}"

	#-> if sonarr was running at start, start it
	if [[ "$running" == "true" ]] ; then
		echo "Starting sonarr"
		systemctl start sonarr
	fi
}