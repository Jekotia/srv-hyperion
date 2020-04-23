file { "${_DATA}/logitech-media-server":
	ensure => directory,
}

file { "${_DATA}/logitech-media-server/config":
	ensure => directory,
}

chown_r { "${_DATA}/logitech-media-server/config":
  want_user   => "101",
  want_group => "65534",
}
