import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class PostingScreen extends StatefulWidget {
  @override
  _PostingScreenState createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final TextEditingController _eventNamecontroller = TextEditingController();
  final TextEditingController _eventDatecontroller = TextEditingController();
  final TextEditingController _eventTimecontroller = TextEditingController();
  final TextEditingController _eventLocationcontroller =
      TextEditingController();
  final TextEditingController _eventDescriptioncontroller =
      TextEditingController();

  String _eventName;
  String _eventDate;
  String _eventTime;
  String _eventLocation;
  String _eventDescription;

  double screenHeight = 0.00, screenWidth = 0.00;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('GUNPLA.INFO'),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: SingleChildScrollView(
                    child: Column(children: [
                  TextField(
                    controller: _eventNamecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Event',
                      icon: Icon(Icons.local_activity),
                    ),
                  ),
                  TextField(
                    controller: _eventDatecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      icon: Icon(Icons.date_range),
                    ),
                  ),
                  TextField(
                    controller: _eventTimecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      icon: Icon(Icons.access_time),
                    ),
                  ),
                  TextField(
                    controller: _eventLocationcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      icon: Icon(Icons.add_location),
                    ),
                  ),
                  TextField(
                    controller: _eventDescriptioncontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      icon: Icon(Icons.description),
                    ),
                  ),
                  SizedBox(height: 25),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: 300,
                    height: 50,
                    child: Text('Post Event'),
                    color: Colors.white,
                    textColor: Colors.black,
                    elevation: 15,
                    onPressed: onPost,
                  ),
                ])))));
  }

  void onPost() async {
    _eventName = _eventNamecontroller.text;
    _eventDate = _eventDatecontroller.text;
    _eventTime = _eventTimecontroller.text;
    _eventLocation = _eventLocationcontroller.text;
    _eventDescription = _eventDescriptioncontroller.text;

    ProgressDialog pd = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pd.style(message: "Posting");
    await pd.show();
    http.post("http://jarfp.com/gunplainfo/php/post_event.php", body: {
      "eventname": _eventName,
      "eventdate": _eventDate,
      "eventtime": _eventTime,
      "eventlocation": _eventLocation,
      "eventdescription": _eventDescription,
    }).then((res) {
      print(res.body);
      if (res.body == "succes") {
        Toast.show(
          "Post Succesful",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        Toast.show(
          "Post Failed",
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
}
