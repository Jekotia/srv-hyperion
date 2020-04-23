#"UUID=${_AUTOMOUNT_UUID}" "${_AUTOMOUNT_PATH}"  auto nosuid,nodev,nofail 0 0
#/dev/disk/by-id/scsi-0Linode_Volume_mercury-srv /srv ext4 defaults,noatime,nofail 0 2
mount { 'external storage':
  name        => $_AUTOMOUNT_PATH,
  ensure      => present,
  atboot      => true,
  #blockdevice => '',
  device      => $_AUTOMOUNT_DEVICE,
  #dump        => '',
  fstype      => $_AUTOMOUNT_FSTYPE,
  options     => "${_AUTOMOUNT_OPTIONS},nofail",
  pass        => 2,
  #provider    => '',
  remounts    => true,
  #target      => '',
}
