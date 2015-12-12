FROM scf37/base

RUN apt-get update && \
    apt-get install -y nginx && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
    rm -rf /var/lib/apt/lists/*

COPY ./start.sh /start.sh
COPY conf /opt/conf

ENTRYPOINT ["/start.sh"]
