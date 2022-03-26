<?php
include("_header.php");

require("_dbconnect.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // collect value of input field
  $id = $_POST['id'];
  if (isset($_POST['accept'])) {
    $sql = "UPDATE `takeLeave` SET `status`= 1 WHERE `id` = $id";
    $result = mysqli_query($conn , $sql);
  }
  if (isset($_POST['denied'])) {
    $sql = "UPDATE `takeLeave` SET `status`= 0 WHERE `id` = $id";
    $result = mysqli_query($conn , $sql);
  }
}

$sql = "SELECT * FROM `takeLeave` WHERE `status` IS NULL";
$result = mysqli_query($conn, $sql);

?>

<div class="container">

  <h2 class="text-center my-5">Leave Applications</h2>

  <table id="student" class="display nowrap">
    <thead>
      <tr>
        <th>ID</th>
        <th>Email</th>
        <th>Reason</th>
        <th>Date</th>
        <th>Request Time/Date</th>
        <th>Accept</th>
        <th>Denied</th>
      </tr>
    </thead>
    <tbody>
      <?php

      while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr>
                    <td>" . $row['id'] . "</td>
                    <td>" . $row['email'] . "</td>
                    <td>" . $row['reason'] . "</td>
                    <td>" . $row['date'] . "</td>
                    <td>" . $row['date_auto'] . "</td>
                    <form action='' method='POST'>
                    <input type='hidden' name='id' value=" . $row['id'] . ">
                    <td> <input type='submit' name='accept'
                    value='Accept'/></td>
                    <td> <input type='submit' name='denied'
                    value='Denied'/></td>
                    </form>
               </tr>";
      }
      ?>
    </tbody>
  </table>
</div>

<?php
include("_footer.php");
?>