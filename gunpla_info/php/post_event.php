<?php
include_once("dbconnect.php");
$eventname = $_POST['eventname'];
$eventdate = $_POST['eventdate'];
$eventtime = $_POST['eventtime'];
$eventlocation = $_POST['eventlocation'];
$eventdescription = $_POST['eventdescription'];


$sqlregister = "INSERT INTO EVENT(EVENTNAME,EVENTDATE,EVENTTIME,EVENTLOCATION, EVENTDESCRIPTION) VALUES('$eventname','$eventdate','$eventtime','$eventlocation' , '$eventdescription')";

if ($conn->query($sqlregister) === TRUE){
    echo "succes";
}else{
    echo "failed";
}
?>