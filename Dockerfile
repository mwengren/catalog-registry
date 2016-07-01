FROM mdillon/postgis:9.5

MAINTAINER Luke Campbell <luke.campbell@rpsgroup.com>

RUN apt-get update && apt-get install -y \
      git \
      sqitch

RUN rm -rf /var/lib/apt/lists/*
COPY sqitch /etc/sqitch
COPY init-sqitch.sh /docker-entrypoint-initdb.d/sqitsh.sh
