<?php

// Database connection parameters
$servername = "db";
$username = "root";
$password = "notSecureChangeMe";
$dbname = "study";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>