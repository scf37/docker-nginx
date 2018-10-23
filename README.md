Nginx 1.15.5 Docker image with HTTP/2 and Brotli support, most other modules included.

To avoid problems with HTTP/2, DO NOT enable `ssl_prefer_server_ciphers`!

If no configuration provided, this image puts default config to /data/conf folder. Default configuration contains no virtual hosts so nginx will not listen any ports until
virtual host config added.

As usual, this image tries to keep moving parts under /data folder.

Documentation for Brotli module is here: https://github.com/google/ngx_brotli
Note: as Brotli compressor is slow, it is REALLY good idea to use pre-compressed resources via `brotli_static` directive.

Typical usage:

- put virtual hosts configuration to /data/nginx/conf/sites-enabled/
- docker create --name cnginx --net=host -v /data/nginx:/data --restart=always scf37/nginx
