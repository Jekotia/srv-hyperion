file { 'multimedia storage':
  path    => $_MULTIMEDIA,
  ensure  => directory,
  owner   => $_USER,
  group   => $_MULTIMEDIA_GROUP,
  # mode    => '0644',
  # recurse => true,
}

chown_r { $_MULTIMEDIA:
  want_user   => $_USER,
  want_group  => $_MULTIMEDIA_GROUP,
}

chmod_r { $_MULTIMEDIA:
  want_mode   => "0775",
}
