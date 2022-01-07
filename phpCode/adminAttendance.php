<?php

$servername = "localhost";
$username = "id18223159_root";
$password = 'A$IGotnc8uqh2xvT';
$database = "id18223159_ams";

// Create a connection

$conn = mysqli_connect($servername, $username, $password, $database);

include("_header.php");

$sql = "SELECT * FROM `attendance`";
$result = mysqli_query($conn , $sql);

?>

<div class="container">

    <h2 class="text-center my-5">Attendance</h2>

    <table id="student" class="display nowrap">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <?php
            
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                    <td>". $row['id'] ."</td>
                    <td>". $row['name'] ."</td>
                    <td>". $row['email'] ."</td>
                    <td>". $row['date'] ."</td>
               </tr>";
            }
            ?>
        </tbody>
    </table>
</div>

<?php
include("_footer.php");
?>