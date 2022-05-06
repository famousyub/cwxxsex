<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "famousme";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
$pass="$2y$10$ " . "ThWGjh5Jly8qP6FMQApQ3OQElLLuwN03jlZMFdQngphJw7";
//$p = password_hash($pass, PASSWORD_BCRYPT);
echo $pass;
$sql = "UPDATE Wo_Users SET password='$pass' WHERE user_id=3";

if ($conn->query($sql) === TRUE) {
  echo "Record updated successfully";
} else {
  echo "Error updating record: " . $conn->error;
}

$conn->close();
?>

<p>
passw0rd
</p>
