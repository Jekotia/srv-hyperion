#-> Application configuration
file { $_JACKETT_DATA:
  ensure => directory,
  owner  => $_JACKETT_UID,
  group  => $_JACKETT_GID,
}

chown_r { $_JACKETT_DATA:
  want_user   => $_JACKETT_UID,
  want_group  => $_JACKETT_GID,
}

chmod_r { $_JACKETT_DATA:
  want_mode => "0755",
}
