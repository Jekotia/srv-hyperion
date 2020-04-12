class { 'docker':
  docker_ce_package_name => 'docker-ce',
  docker_users           => [ $_USER ],
  extra_parameters => [
    '--experimental=true',
    '--metrics-addr=127.0.0.1:9323'
  ],
}
# class {'docker::compose':
#   ensure => absent,
#   #version => '1.22.0',
# }

exec { "Install docker-compose":
  command   => "/usr/bin/bash ${_ROOT}/scripts/docker-compose.sh install",
  creates   => "/usr/local/bin/docker-compose",
  logoutput => true,
}

package { 'composerize':
  ensure   => 'present',
  provider => 'npm',
}
