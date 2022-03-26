<?php

require("_dbconnect.php");

include("_header.php");

$sql = "SELECT * FROM `takeLeave`";
$result = mysqli_query($conn , $sql);

?>

<div class="container">

    <h2 class="text-center my-5">Take Leave</h2>

    <table id="student" class="display nowrap">
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Reason</th>
                <th>Date</th>
                <th>Request Time/Date</th>
            </tr>
        </thead>
        <tbody>
            <?php
            
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                    <td>". $row['id'] ."</td>
                    <td>". $row['email'] ."</td>
                    <td>". $row['reason'] ."</td>
                    <td>". $row['date'] ."</td>
                    <td>". $row['date_auto'] ."</td>
               </tr>";
            }
            ?>
        </tbody>
    </table>
</div>

<?php
include("_footer.php");
?>