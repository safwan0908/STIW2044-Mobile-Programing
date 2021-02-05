<?php
    $servername = "localhost";
    $username = "jarfpcom_gunplainfodbadmin";
    $password = "MKnk6fr*!ma8";
    $dbname = "jarfpcom_gunplainfodb";
    
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
?>