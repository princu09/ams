<?php

require("_dbconnect.php");


$username = $_POST['email'];
// $username = "prince@nfg.com";

// $username = "admin@nfg.com";
// $password = "admin";

    
$sql = "SELECT * FROM `takeLeave` WHERE `email` = '".$username."' AND `status` = 1 ";
$result = mysqli_query($conn , $sql);

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}
    echo json_encode($data);
    // echo json_decode($data);
?>