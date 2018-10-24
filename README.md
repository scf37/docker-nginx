Nginx 1.15.5 Docker image with HTTP/2 and Brotli support, most other modules included.

To avoid problems with HTTP/2, DO NOT enable `ssl_prefer_server_ciphers`!

If no configuration provided, this image puts default config to /data/conf folder. Default configuration contains no virtual hosts so nginx will not listen any ports until
virtual host config added.

As usual, this image tries to keep moving parts under /data folder.

Documentation for Brotli module is here: https://github.com/google/ngx_brotli
Note: as Brotli compressor can be 2x slower than gzip for default compression level (6) and less useful on lower compression levels, it is good idea to use Brotli filter for HTML only.

Typical usage:

- put virtual hosts configuration to /data/nginx/conf/sites-enabled/
- docker create --name cnginx --net=host -v /data/nginx:/data --restart=always scf37/nginx
