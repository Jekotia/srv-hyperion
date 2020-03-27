user { $_SONARR_USER:
  ensure => present,
  groups => [ $_SONARR_GROUP, $_MULTIMEDIA_GROUP ],
  shell  => '/usr/sbin/nologin'
}

group { $_SONARR_GROUP:
  ensure => present,
}
