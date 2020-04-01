function backup_jackett() {
	local source="$_JACKETT_DATA"
	local running="false"
	echo

	#-> check if jackett is running
	if docker ps | grep jackett > /dev/null ; then
		local running="true"

		#-> stop service if running
		echo "Stopping jackett"
		docker stop jackett
	fi

	#du -sh --exclude-from="$exclusion_file"  $_DATA/*
	du -sh $source

	#-> backup jackett data
	tar \
		-cf "${outputDir}/jackett.tar" \
		$tar_args \
		"${source}"

	#-> if jackett was running at start, start it
	if [[ "$running" == "true" ]] ; then
		echo "Starting jackett"
		docker start jackett
	fi
}