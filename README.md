# r_d
/task_11 includes docker-compose.yml for 4 containers:
db - default MariaDB image with init sql script to setup study DB and example table
phpmyadmin - for debug purposes and DB structure navigation
php_viewer - app has enabled apache2 webserver and php-app that connects to DB and displays content of example table
php_worker - php-based app that inserts new value based on pervious to the example table once a minute at a random second
