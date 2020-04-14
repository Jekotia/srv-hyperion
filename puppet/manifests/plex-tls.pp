#55 0 * * * "/home/jekotia/.acme.sh"/acme.sh --cron --home "/home/jekotia/.acme.sh" > /dev/null
cron { "plex ssl":
	ensure		  => "present",
	environment	=> "MAILTO=${_ALERTS_EMAIL}",
	command		  => "/usr/bin/bash ${_ROOT}/scripts/plex-tls.sh --cron",
	user		    => $_USER,
	minute		  => "55",
	hour		    => "0",
	monthday	  => "absent",
	month		    => "absent",
	weekday		  => "absent",
	special		  => "absent",
}

#-> Secure sensitive data against access from other users

chown_r { "${_ROOT}/acme":
  want_user   => $_USER,
  want_group  => $_GROUP,
}

chmod_r { "${_ROOT}/acme":
  want_mode   => "0700",
}

file { "${_DATA}/shared":
	ensure => directory,
}

chown_r { "${_DATA}/shared/${_NAME}-plex-certificate.pkfx":
  want_user   => $_USER,
}

chmod_r { "${_DATA}/shared/${_NAME}-plex-certificate.pkfx":
  want_mode   => "0770",
}
