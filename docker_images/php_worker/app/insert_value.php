<?php

require 'database_connection.php';

// Get the current value of the number_to_show column
$sql = "SELECT value FROM example ORDER BY ID DESC LIMIT 1";
$result = $conn->query($sql);
$hosts_content = shell_exec('tail -1 /etc/hosts');
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $current_value = $row['value'];
} else {
    $current_value = 0;
}
$rand_value = rand(5, 20);
$new_value = $current_value + $rand_value;

// Insert a new row with the incremented value and comment
$sql = "INSERT INTO example (value, last_update, comment)
VALUES ($current_value + $rand_value, NOW(), CONCAT('Modified value $current_value. Added value $rand_value by $hosts_content'));";
$conn->query($sql);
// Close the connection
$conn->close();
?>