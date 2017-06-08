FROM debian:jessie

# install squid and remove default configuration file
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y squid3 \
  && mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist \
  && rm -rf /var/lib/apt/lists/*

# add entrypoint script
ADD build/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# run entrypoint script
ENTRYPOINT ['/docker-entrypoint.sh']