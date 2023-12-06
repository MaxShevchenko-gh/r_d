<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Query Result</title>
    <style>
        body {
            font-family: sans-serif;
            font-size: 16px;
            background-color: #f2f2f2;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th {
            background-color: #f0f0f0;
            padding: 10px;
            text-align: left;
            border: 1px solid #ccc;
        }

        td {
            padding: 10px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
<div id="databaseTable"></div>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
    $(document).ready(function() {
      setInterval(function() {
        refreshTable();
      }, 5000); // Refresh every 5 seconds
    });

    function refreshTable() {
      $.ajax({
        url: 'db_read.php',
        method: 'GET',
        success: function(data) {
          $('#databaseTable').html(data); // Replace current table content with updated data
        }
      });
    }
  </script>
</head>
<body>

<div id="databaseTable"></div>

</body>
</html>