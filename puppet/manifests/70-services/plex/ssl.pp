#55 0 * * * "/home/jekotia/.acme.sh"/acme.sh --cron --home "/home/jekotia/.acme.sh" > /dev/null
cron { "plex ssl":
	ensure		  => "present",
	environment	=> "MAILTO=${_ALERTS_EMAIL}",
	command		  => "/srv/${_NAME}/plex-tls.sh --cron",
	user		    => $_USER,
	minute		  => "55",
	hour		    => "0",
	monthday	  => "absent",
	month		    => "absent",
	weekday		  => "absent",
	special		  => "absent",
}
