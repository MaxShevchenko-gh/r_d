# syntax=docker/dockerfile:1
FROM ubuntu/apache2:latest
# Installing packages

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
apt-get install -y libapache2-mod-php php php-mysqli 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*


RUN a2enmod rewrite
# Modify default index page to php
COPY /etc/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN touch /var/www/html/.htaccess
RUN echo 'DirectoryIndex index.php index.html' > /var/www/html/.htaccess

# Copying application files
COPY /src /var/www/html

WORKDIR /var/www/html

CMD ["apache2ctl", "-D", "FOREGROUND"]