package { 'zsh':  ensure  => 'installed' }

user { $_USER:
  ensure     => present,
  managehome => 'true',
  shell      => '/usr/bin/zsh',
  comment    => 'Primary user',
  groups     => [ $_GROUP, $_MULTIMEDIA_GROUP ],
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
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDRvdduzwOuCMFHXEDOyH1gB/WiQXO/mf/D+tWllIXhEqUPap73jmVU/Rx3MMLPaitHpTQ1ULl8UnwxsI4ZnZeRMlvomGtUHXL2wMFViEXSV3TJOt9KJu6hj5HR9/uI/c8z3iu6pA06oGyXHJ8qv+woF1f2icojmUk0tIH3Fqa3SMNdmW1u+kw1dk0UcxtV8XgLb+hRVZqVPbopttwn6Er7CT45ad00dog7YAIlm3gCFOlyIBJzTvCOcgInU7jpnnmXJyIkEIzjmphS0GRwr4sHNZSN8kOOy+H3y9XhM7fO4WNHRhIUPY7TScFormAJW4fZKzopiGp/1jiSB1yN6jC1',
}
