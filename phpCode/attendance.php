<?php

require("_dbconnect.php");

$date = $_POST['date'];
$name = $_POST['name'];
$email = $_POST['email'];


// $username = "admin@nfg.com";
// $password = "admin";


$check = "SELECT `id`, `name`, `email`, `date` FROM `attendance` WHERE `email` = '".$email."' AND `date` = '".$date."' ";
$result = mysqli_query($conn , $check);

$num = mysqli_num_rows($result);

if ($num == 0) {
    $sql = "INSERT INTO `attendance` (`name`, `email`, `date`) VALUES ('".$name."', '".$email."', '".$date."');";
    $result2 = mysqli_query($conn , $sql);
    
    echo("Attendance Taken Successfully.");
}
else{
    echo("Attendance Already Taken.");
}

?>