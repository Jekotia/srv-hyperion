class { 'docker':
  docker_ce_package_name => 'docker-ce',
  docker_users           => [ $_USER ],
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
