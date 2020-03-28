user { $_RADARR_USER:
  ensure => present,
  groups => [ $_RADARR_GROUP, $_MULTIMEDIA_GROUP ],
  shell  => '/usr/sbin/nologin'
}

group { $_RADARR_GROUP:
  ensure => present,
}
