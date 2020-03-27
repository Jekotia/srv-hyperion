file { 'multimedia storage':
  path    => $_MULTIMEDIA,
  ensure  => directory,
  owner   => $_PLEX_USER,
  group   => $_MULTIMEDIA_GROUP,
  # mode    => '0644',
  # recurse => true,
}

chown_r { $_MULTIMEDIA:
  # want_user   => $_PLEX_USER,
  want_group  => $_MULTIMEDIA_GROUP,
}
