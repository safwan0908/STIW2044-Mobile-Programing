import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gunpla_info/registerscreen.dart';

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
                    onPressed: () {},
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
}
