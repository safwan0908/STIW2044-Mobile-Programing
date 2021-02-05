import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gunpla_info/postingscreen.dart';
import 'package:http/http.dart' as http;



class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List eventlist;
  double screenHeight = 0.00, screenWidth = 0.00;
  String titlecenter = "Loading Event...";

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('GUNPLA.INFO'),
          actions: <Widget>[
            Flexible(child:
              IconButton(
                icon:Icon(Icons.cached), 
                onPressed:(){
                  _loadPost();
                } 
              )
            )
          ],
        ),
        body: new Column(
          children: [
            eventlist == null
                ? Flexible(
                    child: Container(
                        child: Center(
                            child: Text(
                    titlecenter,
                  ))))
                : Flexible(
                    child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: (screenWidth / screenHeight) / 0.3,
                        children: List.generate(eventlist.length, (index) {
                          return Padding(
                              padding: EdgeInsets.all(1),
                              child: Card(
                                child: InkWell(
                                child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                            "Event: " +
                                                eventlist[index]['eventname'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                            "Date: " +
                                                eventlist[index]['eventdate'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                            "Time: " +
                                                eventlist[index]['eventtime'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                            "Event: " +
                                                eventlist[index]
                                                    ['eventlocation'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                            "Description: " +
                                                eventlist[index]
                                                    ['eventdescription'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ))
                                      ]))
                                ],
                              ))));
                        })),
                  ),
            Padding(
              padding: EdgeInsets.fromLTRB(250, 0, 5, 10),
              child: new FloatingActionButton(
                  backgroundColor: const Color(0xFFfffdfd),
                  child: new Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                  onPressed: onPostingScreen),
            ),


          ],
        ));
  }

  void onPostingScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => PostingScreen()));
  }

  void _loadPost() {
    http.post("http://jarfp.com/gunplainfo/php/load_event.php", body: {}).then(
        (res) {
      print(res.body);
      if (res.body == "nodata") {
        eventlist = null;
        setState(() {
          titlecenter = "No Event";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          eventlist = jsondata["event"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
