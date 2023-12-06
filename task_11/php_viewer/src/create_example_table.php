<?php
require 'database_connection.php';

// Create the 'example' table if it doesn't exist
$sql = "CREATE TABLE IF NOT EXISTS `example` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) NOT NULL DEFAULT 0,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

$conn->query($sql);

echo "Example table created successfully.";

$conn->close();