import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  String _email = "";
  String _password = "";
  String _name = "";
  String _phone = "";
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person),
                  ),
                ),
                TextField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                ),
                TextField(
                  controller: _phonecontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    icon: Icon(Icons.phone),
                  ),
                ),
                TextField(
                  controller: _passcontroller,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: passwordVisible,
                ),
                SizedBox(height: 50),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minWidth: 300,
                  height: 50,
                  child: Text('Register'),
                  color: Colors.white,
                  textColor: Colors.black,
                  elevation: 15,
                  onPressed: onRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onRegister() async {
    _name = _namecontroller.text;
    _email = _emailcontroller.text;
    _phone = _phonecontroller.text;
    _password = _passcontroller.text;

    if (validateEmail(_email) && validatePassword(_password)) {
      Toast.show(
        "Check your email/password",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      return;
    }

    ProgressDialog pd = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pd.style(message: "Registrating...");
    await pd.show();
    http.post("http://jarfp.com/gunplainfo/php/register_user.php", 
      body: {
        "name": _name,
        "email": _email,
        "phone": _phone,
        "password": _password,
      }).then((res) {
        print(res.body);
        if (res.body == "succes") {
          Toast.show(
            "Registration success. Plese check your EMAIL INBOX for verification",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        } else {
          Toast.show(
            "Registration failed",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        }
     }).catchError((err) {
      print(err);
      });
    await pd.hide();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validatePassword(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }
}