<?php
error_reporting(0);
include_once("dbconnect.php");

$sql = "SELECT * FROM EVENT"; 
$result = $conn->query($sql);

if ($result->num_rows > 0){
     $response["event"] = array();
    while ($row = $result->fetch_assoc()){
        $eventlist = array();
        $eventlist[eventname] = $row["EVENTNAME"];
        $eventlist[eventdate] = $row["EVENTDATE"];
        $eventlist[eventtime] = $row["EVENTTIME"];
        $eventlist[eventlocation] = $row["EVENTLOCATION"];
        $eventlist[eventdescription] = $row["EVENTDESCRIPTION"];
        array_push($response["event"], $eventlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>