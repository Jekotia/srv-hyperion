apt::source { 'sonarr':
  comment  => 'Sonarr media downloader',
  location => 'http://apt.sonarr.tv/',
  release  => 'master',
  repos    => 'main',
  key      => {
    'id'     => '0xA236C58F409091A18ACA53CBEBFF6B99D9B78493',
    'server' => 'keyserver.ubuntu.com'
  },
  include  => {
    'src' => false,
    'deb' => true,
  },
}

$sonarr_packages = [
  'nzbdrone',
]

package { $sonarr_packages: ensure => 'installed' }
