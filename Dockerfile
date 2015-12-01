###############################################################################
### Dockerfile to run cdash ###################################################
###############################################################################
FROM ubuntu:15.04
MAINTAINER Julien Graziano <julien.graziano@arobas-music.com>
# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 curl git libapache2-mod-php5 php5-curl php5-dev php5-gd php5-mysql php5-sqlite php5-pgsql php5-xsl unzip wget
# Configure apache
ADD apache2.conf /etc/apache2/apache2.conf
# Setup CDash
ADD cdash /srv/cdash
RUN mkdir /srv/cdash/www-data
# Configure container
VOLUME /srv/cdash/www-data
VOLUME /srv/cdash/backup
VOLUME /srv/cdash/upload
VOLUME /srv/cdash/rss
VOLUME /var/log/apache2
COPY httpd-foreground /usr/local/bin/
EXPOSE 8080
CMD ["httpd-foreground"]
