file { 'multimedia link':
  path   => '/var/lib/plexmediaserver/Library',
  ensure => 'link',
  target => $_MULTIMEDIA,
  owner  => $_PLEX_USER,
  group  => $_MULTIMEDIA_GROUP,
}
