###############################################################################
### Dockerfile to run cdash ###################################################
###############################################################################
FROM ubuntu:15.04
MAINTAINER Julien Graziano <julien.graziano@arobas-music.com>
# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 curl git libapache2-mod-php5 php5-curl php5-dev php5-gd php5-mysql php5-sqlite php5-pgsql php5-xsl unzip wget
# Setup CDash
ADD apache.conf /etc/apache2/sites-available/cdash.conf
ADD cdash-ssl-cert.crt /srv/
ADD cdash-ssl-cert.key /srv/
ADD cdash /srv/cdash
RUN mkdir /srv/cdash/www-data
# Configure apache
RUN chown -R www-data:www-data /srv/cdash
RUN a2dissite 000-default
RUN a2enmod ssl
RUN a2ensite cdash
# Configure container
VOLUME /srv/cdash/www-data
VOLUME /srv/cdash/backup
VOLUME /srv/cdash/upload
VOLUME /srv/cdash/rss
VOLUME /var/log/apache2
EXPOSE 80 443
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
