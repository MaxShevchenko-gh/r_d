<?php
ini_set('display_errors', 1);

require 'database_connection.php';

// SQL query to get the last 5 rows from the 'example' table
$sql = "SELECT * FROM (SELECT * FROM example ORDER BY id DESC LIMIT 10) AS subquery ORDER BY ID ASC";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Output data in a table
  echo "<table border='1'>
    <tr>
      <th>ID</th>
      <th>Value</th>
      <th>Note</th>
      <th>Timestamp</th>
    </tr>";

  // Output data of each row
  while ($row = $result->fetch_assoc()) {
    echo "<tr>
      <td>" . $row["ID"] . "</td>
      <td>" . $row["value"] . "</td>
      <td>" . $row["comment"] . "</td>
      <td>" . $row["last_update"] . "</td>
    </tr>";
  }

  echo "</table>";
} else {
  echo "0 results";
}

// Close connection
$conn->close();
?>