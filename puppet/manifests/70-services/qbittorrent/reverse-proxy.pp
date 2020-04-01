$qbittorrent_reverse_proxy = @("EOT"/$)
location /torrent/ {
  proxy_pass              http://127.0.0.1:${_QBITTORRENT_PORT}/;
  proxy_http_version      1.1;
  proxy_set_header        X-Forwarded-Host \$http_host;
  http2_push_preload on; # Enable http2 push
  # The following directives effectively nullify Cross-site request forgery (CSRF)
  # protection mechanism in qBittorrent, only use them when you encountered connection problems.
  # You should consider disable "Enable Cross-site request forgery (CSRF) protection"
  # setting in qBittorrent instead of using these directives to tamper the headers.
  # The setting is located under "Options -> WebUI tab" in qBittorrent since v4.1.2.
  #proxy_hide_header       Referer;
  #proxy_hide_header       Origin;
  #proxy_set_header        Referer                 '';
  #proxy_set_header        Origin                  '';
  # Not needed since qBittorrent v4.1.0
  #add_header              X-Frame-Options         "SAMEORIGIN";
}
EOT

#file { "${_NGINX_LOCATIONS}/torrent.conf":
#file { "/etc/nginx/sites-enabled/torrent.${_DNS_NAME}":
file { "/etc/nginx/${_NAME}-locations/torrent":
  ensure  => file,
  content => $qbittorrent_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
