host { 'system':
  ensure => 'present',
  name   => $_NAME,
  ip     => $_IP,
}

class {'hostname':
        hostname => $_NAME,
        domain   => 'jekotia.net'
}

class { 'timezone':
    timezone => 'America/Toronto',
}

class { 'locales':
  ensure         => 'present',
  default_locale => 'en_CA.UTF-8',
  locales        => ['en_CA.UTF-8 UTF-8'],
}

cron { 'cfdns-update':
  ensure      => 'present',
  environment => "MAILTO=${_ALERTS_EMAIL}",
  command     => "${_SCRIPT_CFDNS} > /dev/null 2>&1",
  user        => "${_USER}",
  minute      => '*/5',
  hour        => 'absent',
  monthday    => 'absent',
  month       => 'absent',
  weekday     => 'absent',
  special     => 'absent',
}

file { 'server data folder':
  ensure => 'directory',
  path   => $_DATA,
}

file { 'server logs folder':
  ensure => 'directory',
  path   => $_LOGS,
}

#class { 'ssh::server':
#  storeconfigs_enabled => false,
#  options => {
#    'PasswordAuthentication' => 'no',
#    'PermitRootLogin'        => 'no',
#    'Port'                   => [22, 2222],
#  },
#}

class { 'unattended_upgrades':
  age                  => {
    'min' => 10,
    'max' => 10
  },
  auto                 => {
    'reboot'               => false,
    'fix_interrupted_dpkg' => true,
    'remove'               => true
  },
  enable               => 1,
  install_on_shutdown  => false,
  legacy_origin        => false,
  mail                 => {
    'to'      => "${_ALERTS_EMAIL}"
  },
  minimal_steps        => true,
  # origins              => [
  #   'http://mirrors.linode.com/debian stretch main',
  #   'http://mirrors.linode.com/debian-security stretch/updates main',
  #   'http://mirrors.linode.com/debian stretch-updates main'
  # ],
  package_ensure       => installed,
  update               => 1,
  upgrade              => 1,
  upgradeable_packages => {
    'debdelta'    => 1
  },
}

#-> Secure sensitive data against access from other users
chown_r { "${_ROOT}/config":
  want_user   => $_USER,
  want_group  => $_GROUP,
}

chmod_r { "${_ROOT}/config":
  want_mode   => "0700",
}
