$nginx_packages = [
  'nginx',
]

package { $nginx_packages: ensure => 'installed' }
