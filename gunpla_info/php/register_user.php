<?php
include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(1000,9999);


$sqlregister = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD, OTP) VALUES('$name','$email','$phone','$password' , '$otp')";

if ($conn->query($sqlregister) === TRUE){
    sendmail($otp,$email );
    echo "succes";
}else{
    echo "failed";
}

function sendmail($otp,$email){
    $from = "noreply@gunplainfo.com";
    $to = $email;
    $subject = "From GUNPLA.INFO. Verify your account";
    $message = "Use the following link to verify your account :"."\n http://jarfp.com/gunplainfo/php/verify_account.php?email=".$email."&key=".$otp;
    $headers = "From:" . $from;
    mail($email,$subject,$message, $headers);
}
?>