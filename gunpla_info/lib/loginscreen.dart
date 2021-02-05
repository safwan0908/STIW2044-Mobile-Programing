import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gunpla_info/registerscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:gunpla_info/feedscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontorller = TextEditingController();
  String email = "";

  final TextEditingController passcontorller = TextEditingController();
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SIGN IN'),
        ),
        body: new Container(
            padding: EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      controller: emailcontorller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email))),
                  TextField(
                    controller: passcontorller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: 300,
                    height: 50,
                    child: Text('Login'),
                    color: Colors.white,
                    textColor: Colors.black,
                    elevation: 15,
                    onPressed: onLogin,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: onRegister,
                      child: Text('Does not have an account?')),
                ],
              ),
            )),
      ),
    );
  }

  void onRegister() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

    Future<void> onLogin() async {
    email = emailcontorller.text;
    pass = passcontorller.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();
    http.post("http://jarfp.com/gunplainfo/php/login_user.php", body: {
      "email": email,
      "password": pass,
    }).then((res) {
      print(res.body);
      List userdata = res.body.split(",");
      if (userdata[0] == "success") {
        Toast.show(
          "Login Succes",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => FeedScreen()));
      } else {
        Toast.show(
          "Login failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }
}
