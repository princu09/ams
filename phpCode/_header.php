<?php

$servername = "localhost";
$username = "id18223159_root";
$password = 'A$IGotnc8uqh2xvT';
$database = "id18223159_ams";


// Create a connection

$conn = mysqli_connect($servername, $username, $password, $database);

?>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

    <title>Admin Site | AMS</title>

    <script src="jquery-3.5.1.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.11.3/b-2.1.1/b-colvis-2.1.1/b-html5-2.1.1/b-print-2.1.1/datatables.min.css" />

</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand font-weight-bold" href="#">Attedance Managemnet System</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.php">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminStudents.php">Students</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminTakeLeave.php">Take Leave</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminAttendance.php">Attedance</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminAnnouncement.php">Announcement</a>
                </li>
            </ul>
        </div>
    </nav>