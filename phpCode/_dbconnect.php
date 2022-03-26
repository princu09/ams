<?php


// $servername = "localhost";
// $username = "id18223159_root";
// $password = 'A$IGotnc8uqh2xvT';
// $database = "id18223159_ams";

$servername = "localhost";
$username = "root";
$password = '';
$database = "id18223159_ams";

// Create a connection

$conn = mysqli_connect($servername, $username, $password, $database);

if($conn){
    
}else{
    echo "Connection Failed";
    exit();
}

?>