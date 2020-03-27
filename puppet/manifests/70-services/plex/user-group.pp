user { $_PLEX_USER:
  ensure => present,
  groups => [ $_PLEX_GROUP, 'render', $_MULTIMEDIA_GROUP ],
  shell  => '/usr/sbin/nologin'
}

group { $_PLEX_GROUP:
  ensure => present,
}
