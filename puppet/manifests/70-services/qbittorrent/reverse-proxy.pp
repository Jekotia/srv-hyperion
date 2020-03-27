$qbittorrent_reverse_proxy = @("EOT"/$)
server {
  listen 80;
  listen [::]:80;

  server_name    torrent.${_DNS_NAME};

  location / {
    proxy_pass              http://127.0.0.1:9091/;
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

  access_log            ${_LOGS}/nginx/torrent.${_DNS_NAME}.access.log combined;
  error_log             ${_LOGS}/nginx/torrent.${_DNS_NAME}.error.log;
}
EOT

#file { "${_NGINX_LOCATIONS}/torrent.conf":
file { "/etc/nginx/sites-enabled/torrent.${_DNS_NAME}":
  ensure  => file,
  content => $qbittorrent_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
