Nginx 1.9.15 Docker image with HTTP/2 support, most other modules included.

To avoid problems with HTTP/2, DO NOT enable `ssl_prefer_server_ciphers`!

If no configuration provided, this image put default config to /data/conf folder. Default configuration contains no virtual hosts so nginx will not listen any ports until
virtual host config added.

As usual, this image tries to keep moving parts under /data folder.


Typical usage:

- put virtual hosts configuration to /data/nginx/conf/sites-enabled/
- docker create --name cnginx --net=host -v /data/nginx:/data --restart=always scf37/nginx
