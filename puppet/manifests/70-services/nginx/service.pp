service { 'nginx':
  name => 'nginx',
  ensure => 'running',
  enable => true,
}
