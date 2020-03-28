file { "${_ROOT}/www":
  ensure => directory,
  owner  => $_USER,
  group  => $_NGINX_GROUP,
}
chown_r { "${_ROOT}/www":
  want_user   => $_USER,
  want_group  => $_NGINX_GROUP,
}
chmod_r { "${_ROOT}/www":
  want_mode => "0775",
}
