$plex_reverse_proxy = @("EOT"/$)
server {
  listen 80;
  listen [::]:80;

  server_name    plex.${_DNS_NAME};

  location / {
    proxy_pass              http://127.0.0.1:32400/;
    proxy_http_version      1.1;
    proxy_set_header        X-Forwarded-Host \$http_host;
    http2_push_preload on; # Enable http2 push
  }

  access_log            ${_LOGS}/nginx/plex.${_DNS_NAME}.access.log combined;
  error_log             ${_LOGS}/nginx/plex.${_DNS_NAME}.error.log;
}
EOT

file { "/etc/nginx/sites-enabled/plex.${_DNS_NAME}":
  ensure  => file,
  content => $plex_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
