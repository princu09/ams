<?php

require("_dbconnect.php");

    
$sql = "SELECT * FROM `announcement` ORDER BY `announcement`.`id` DESC";
$result = mysqli_query($conn , $sql);

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}
    echo json_encode($data);
    // echo json_decode($data);
?>