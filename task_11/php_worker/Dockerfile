# syntax=docker/dockerfile:1
FROM ubuntu:latest
# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y cron tzdata
RUN apt-get install -y php php-mysqli
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Copy scripts and files into the container
COPY /app/database_connection.php /app/database_connection.php
COPY /app/insert_value.php /app/insert_value.php
COPY /app/rnd.sh /app/rnd.sh
COPY /app/crontab /etc/cron.d/crontab

# Give execution permissions to the script
RUN chmod +x /app/insert_value.php
RUN chmod +x /app/rnd.sh

CMD ["cron", "-f"]