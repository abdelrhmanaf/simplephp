<!DOCTYPE html>
<html>
<head>
	<title>Hello World!</title>
</head>
<body>
	<h1>Hello World!</h1>
	<p>Thank you for visiting our website.</p>
	<?php
	$servername = "localhost";
	$username = "aaf";
	$password = "admin123";
	$dbname = "users";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Check connection
	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	}

	// Get visitor's IP address
	$ip_address = $_SERVER['REMOTE_ADDR'];

	// Get current time
	$current_time = date("Y-m-d H:i:s");

	// Insert visitor's IP address and current time into database
	$sql = "INSERT INTO users (ip_address, visit_time) VALUES ('$ip_address', '$current_time')";

	if ($conn->query($sql) === TRUE) {
	    echo "Your IP address ('$ip_address') and the current time ('$current_time') have been recorded in the database.";
	} else {
	    echo "Error: " . $sql . "<br>" . $conn->error;
	}

	$conn->close();
	?>
</body>
</html>