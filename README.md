Nginx 1.19.4 Docker image with HTTP/2 and Brotli support, most other modules included.


Use this configuration for A+ score on ssllabs:
```nginx
ssl_session_cache shared:SSL:20m;
ssl_session_timeout 10m;
ssl_prefer_server_ciphers on;
ssl_stapling on;
ssl_dhparam dhparam.pem;
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_protocols TLSv1.2 TLSv1.3;
```

If no configuration provided, this image puts default config to /data/conf folder. Default configuration contains no virtual hosts so nginx will not listen any ports until
virtual host config added.

As usual, this image tries to keep moving parts under /data folder.

Documentation for Brotli module is here: https://github.com/google/ngx_brotli
Note: as Brotli compressor can be 2x slower than gzip for default compression level (6) and less useful on lower compression levels, it is good idea to use Brotli filter for HTML only.

Typical usage:

- put virtual hosts configuration to /data/nginx/conf/sites-enabled/
- docker create --name cnginx --net=host -v /data/nginx:/data --restart=always scf37/nginx
