#!/bin/sh
current_time=$(date +%s)
random_number=$((current_time % 60))
sleep $random_number && php /app/insert_value.php && logger "Value inserted" > /dev/stdout