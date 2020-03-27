apt::source { 'plex':
  comment  => 'Plex media server',
  location => 'https://downloads.plex.tv/repo/deb/',
  release  => 'public',
  repos    => 'main',
  key      => {
    'id'     => 'CD665CBA0E2F88B7373F7CB997203C7B3ADCA79D',
    'source' => 'https://downloads.plex.tv/plex-keys/PlexSign.key'
  },
  include  => {
    'src' => false,
    'deb' => true,
  },
}

$plex_packages = [
  'plexmediaserver',
]

package { $plex_packages: ensure => 'installed' }
