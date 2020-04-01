function backup_qbittorrent() {
	local source="$_QBITTORRENT_DATA"
	local running="false"
	echo
#du -sh --exclude-from="$exclusion_file"  $_DATA/*

	#-> check if qbittorrent is running
	if systemctl status qbittorrent --no-pager > /dev/null ; then
		local running="true"

		#-> stop service if running
		echo "Stopping qbittorrent"
		systemctl stop qbittorrent
	fi

	du -sh $source

	#-> backup qbittorrent data
	tar \
		-cf "${outputDir}/qbittorrent.tar" \
		$tar_args \
		"${source}"

	#-> if qbittorrent was running at start, start it
	if [[ "$running" == "true" ]] ; then
		echo "Starting qbittorrent"
		systemctl start qbittorrent
	fi
}