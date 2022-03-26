<?php


require("_dbconnect.php");

$date = $_POST['date'];
$reason = $_POST['reason'];
$email = $_POST['email'];


// $username = "admin@nfg.com";
// $password = "admin";
    
    
$sql = "INSERT INTO `takeLeave` (`date`, `reason`, `email`, `date_auto`) VALUES ('".$date."', '".$reason."', '".$email."', current_timestamp());";
$result = mysqli_query($conn , $sql);

?>