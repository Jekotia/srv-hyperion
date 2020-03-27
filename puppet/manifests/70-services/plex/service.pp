service { 'plex':
  name => 'plexmediaserver',
  ensure => 'running',
  enable => true,
}
