package { 'zsh':  ensure  => 'installed' }

user { $_USER:
  ensure     => present,
  managehome => 'true',
  shell      => '/usr/bin/zsh',
  comment    => 'Primary user',
  groups     => [ $_GROUP ],
}

group { $_GROUP:
  ensure => present,
}

class { 'sudo': }
sudo::conf { $_USER:
  ensure   => 'present',
  priority => 99,
  content  => "${_USER} ALL=(ALL) NOPASSWD: ALL",
}

ssh_authorized_key { $_USER:
  ensure => present,
  user   => $_USER,
  type   => 'ssh-rsa',
  key    => $_SSH_PUBLIC_KEY,
}
