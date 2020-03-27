#-> https://github.com/qbittorrent/qBittorrent/wiki/Setting-up-qBittorrent-on-Ubuntu-server-as-daemon-with-Web-interface-(15.04-and-newer)

$qbittorrent_unit_file = @("EOT")
[Unit]
Description=qBittorrent Daemon Service
Documentation=man:qbittorrent-nox(1)
Wants=network-online.target
After=network-online.target nss-lookup.target

[Service]
# if you have systemd >= 240, you probably want to use Type=exec instead
Type=exec
User=${_QBITTORRENT_USER}
ExecStart=/usr/bin/qbittorrent-nox
TimeoutStopSec=infinity
[Install]
WantedBy=multi-user.target
EOT

file { "/tmp/qbittorrent.service":
  ensure  => file,
  content => $qbittorrent_unit_file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}


systemd::unit_file { 'qbittorrent.service':
  source => "/tmp/qbittorrent.service",
  enable => true,
  active => true,
}
