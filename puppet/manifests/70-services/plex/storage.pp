file { 'multimedia link':
  path   => '/var/lib/plexmediaserver/Library/Multimedia',
  ensure => link,
  target => $_MULTIMEDIA,
  owner  => $_PLEX_USER,
  group  => $_MULTIMEDIA_GROUP,
}

file { 'Application Support dir':
  path   => '/var/lib/plexmediaserver/Library/Application Support',
  ensure => directory,
  owner  => $_PLEX_USER,
  group  => $_MULTIMEDIA_GROUP,
}

file { 'Application Support contents link':
  path   => '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server',
  ensure => link,
  target => "${_PLEX_DATA}/Application Support",
  owner  => $_PLEX_USER,
  group  => $_PLEX_GROUP,
}

chown_r { $_PLEX_DATA:
  want_user   => $_PLEX_USER,
  want_group  => $_PLEX_GROUP,
}
