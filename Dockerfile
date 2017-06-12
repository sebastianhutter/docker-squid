FROM debian:jessie

# install squid and remove default configuration file
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y curl squid3 \
  && mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist \
  && ln -sf /dev/stdout /var/log/squid3/access.log \
  && rm -rf /var/lib/apt/lists/*

# add entrypoint script
ADD build/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# run entrypoint script
ENTRYPOINT [ "/docker-entrypoint.sh" ]