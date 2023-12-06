# r_d
## Docker images
docker_images folder includes docker-compose.yml for 4 containers:
- db: default MariaDB image with init sql script to setup study DB and example table
- phpmyadmin: for debug purposes and DB structure navigation
- php_viewer: app has enabled apache2 webserver and php-app that connects to DB and displays content of example table
- php_worker: php-based app that inserts new value based on pervious to the example table once a minute at a random second

Folders /php_viewer and /php_worker include Dockerfile and apps for building the containters php_viewer and php_worker respectively
Folder /db_configuration includes sql script for initial DB setup

## To run the setup:
cd ./docker_images
docker build -t php_viewer ./php_viewer
docker build -t php_worker ./php_worker
docker-compose --build -d up

localhost:8888/index.php will display 10 last inserts to the table `example`
