<?php
$db_name = "flutter_mydb";
$db_user = "root";
$db_pass = "";
$db_host = "localhost";

$con = mysqli_connect($db_host, $db_user, $db_pass,
$db_name);

if ($con->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>