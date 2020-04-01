function backup_radarr() {
	local source="$_RADARR_DATA"
	local running="false"
	echo
#du -sh --exclude-from="$exclusion_file"  $_DATA/*

	#-> check if radarr is running
	if systemctl status radarr --no-pager > /dev/null ; then
		local running="true"

		#-> stop service if running
		echo "Stopping radarr"
		systemctl stop radarr
	fi

	du -sh $source

	#-> backup radarr data
	tar \
		-cf "${outputDir}/radarr.tar" \
		$tar_args \
		"${source}"

	#-> if radarr was running at start, start it
	if [[ "$running" == "true" ]] ; then
		echo "Starting radarr"
		systemctl start radarr
	fi
}