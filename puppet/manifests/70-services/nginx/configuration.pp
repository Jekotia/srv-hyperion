$nginx_config = @("EOT")
server {
  listen 80;
  listen [::]:80;

  server_name    ${_DNS_NAME};

  location / { alias ${_ROOT}/www/; }

  include /etc/nginx/${_NAME}-locations/*.conf;

  access_log            ${_LOGS}/nginx/${_DNS_NAME}.access.log combined;
  error_log             ${_LOGS}/nginx/${_DNS_NAME}.error.log;
}
EOT

file { "/etc/nginx/sites-enabled/${_NAME}.conf":
  ensure  => file,
  content => $nginx_config,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

file { "/etc/nginx/${_NAME}-locations":
  ensure  => directory,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

exec {'Update index':
  command  => "${_PUPPET_ROOT}/scripts/update-index.sh",
  provider => shell,
  onlyif   => [ "test -e ${_ROOT}/www/index.html", "test -f ${_ROOT}/www/index.html" ],
}
# exec { 'reload nginx':
#   command => "/usr/sbin/nginx -s reload",
# }
