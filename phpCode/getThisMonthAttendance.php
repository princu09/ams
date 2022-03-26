<?php

require("_dbconnect.php");

$email = $_POST['email'];

$sql = "SELECT `name`, `email` FROM attendance WHERE MONTH(date) = MONTH(NOW()) AND email = '".$email."' ";
$result = mysqli_query($conn , $sql);

$num = mysqli_num_rows($result);

echo $num;

?>