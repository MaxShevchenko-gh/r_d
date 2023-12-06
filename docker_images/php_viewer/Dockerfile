# syntax=docker/dockerfile:1
FROM ubuntu/apache2:latest
# Installing packages

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
apt-get install -y libapache2-mod-php php php-mysqli 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Modify default index page to php
RUN echo 'DirectoryIndex index.php index.html' > /etc/apache2/sites-enabled/000-default.conf

# Copying application files
COPY /src /var/www/html

# Initial DB Setup
# RUN chmod +x /var/www/html/create_example_table.php
# RUN php /var/www/html/create_example_table.php