<?php
$ip_address = $_SERVER['REMOTE_ADDR'];
$current_time = date('Y-m-d H:i:s');

$conn = mysqli_connect('localhost', 'ubuntu', 'Admin@123', 'users');
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}
mysqli_select_db($conn, 'users');

$sql = "INSERT INTO visitors (ip_address, visit_time) VALUES ('$ip_address', '$current_time')";
if (mysqli_query($conn, $sql)) {
  echo "Hello World! Your IP address is $ip_address and the current time is $current_time.";
} else {
  echo "Error: " . $sql . "<br>" . mysqli_error($conn);
}

mysqli_close($conn);
?>
