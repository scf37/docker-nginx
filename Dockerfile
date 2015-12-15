FROM scf37/base

RUN apt-get update && \
    apt-get install -y make g++ libssl-dev libxslt-dev libgd2-xpm-dev libgeoip-dev libpam-dev && \
    cd /opt && \
    wget http://nginx.org/download/nginx-1.9.9.tar.gz && \
    tar xfz nginx-1.9.9.tar.gz && \
    wget http://zlib.net/zlib-1.2.8.tar.gz && \
    tar xfz zlib-1.2.8.tar.gz && \
    wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2 && \
    tar xfj pcre-8.37.tar.bz2 && \
    wget https://www.openssl.org/source/openssl-1.0.2e.tar.gz && \
    tar xfz openssl-1.0.2e.tar.gz && \
    cd /opt/nginx-1.9.9 && \
    ./configure --with-http_v2_module \
	--conf-path=/etc/nginx/nginx.conf \
	--with-zlib=../zlib-1.2.8 \
	--with-pcre=../pcre-8.37 \
	--with-openssl=../openssl-1.0.2e \
	--with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' \
	--with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro' \
	--prefix=/usr/share/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--http-log-path=/var/log/nginx/access.log \
	--error-log-path=/var/log/nginx/error.log \
	--lock-path=/var/lock/nginx.lock \
	--pid-path=/run/nginx.pid \
	--http-client-body-temp-path=/var/lib/nginx/body \
	--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
	--http-proxy-temp-path=/var/lib/nginx/proxy \
	--http-scgi-temp-path=/var/lib/nginx/scgi \
	--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
	--with-debug \
	--with-pcre-jit \
	--with-ipv6 \
	--with-http_ssl_module \
	--with-http_stub_status_module \
	--with-http_realip_module \
	--with-http_addition_module \
	--with-http_dav_module \
	--with-http_geoip_module \
	--with-http_gzip_static_module \
	--with-http_image_filter_module \
	--with-http_sub_module \
	--with-http_xslt_module \
	--with-mail \
	--with-mail_ssl_module && \
    make && \
    make install && \
    mkdir -p /var/lib/nginx/ && \
    mkdir -p /var/log/nginx/ && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    apt-get remove -y make g++ && \
    #remove artifacts not covered by previous command (for some reasons)
    apt-get remove -y cpp-4.8 gcc-4.8 manpages manpages-dev && \
    apt-get autoremove -y && \
    find /usr/lib -name "*.a" -exec rm -rf {} \; && \
    rm -rf /usr/include && \
    rm -rf /usr/share/doc && \
    rm -rf /usr/share/man && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /opt/*

COPY ./start.sh /start.sh
COPY conf /opt/conf

ENTRYPOINT ["/start.sh"]
