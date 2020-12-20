import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mid_term/book.dart';

class DetailScreen extends StatefulWidget {
  final Book book;

  const DetailScreen({Key key, this.book}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight = 0.00;
  double screenWidth = 0.00;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.book.booktitle),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: screenHeight / 2.5,
                      width: screenWidth / 1.5,
                      child: SingleChildScrollView(
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://slumberjer.com/bookdepo/bookcover/${widget.book.cover}.jpg",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(
                              Icons.broken_image,
                              size: screenWidth / 2),
                        ),
                      ),
                    ),
                    Divider(color: Colors.blue),
                    Text('Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 5),
                    Text(widget.book.description),
                    Divider(color: Colors.blue),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                          child: Text("Book Title",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          child: Text(widget.book.booktitle),
                        ),
                      ],
                    ),
                    Divider(color: Colors.blue),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                          child: Text("Author",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                            child: Text("Price: RM" + widget.book.author)),
                      ],
                    ),
                    Divider(color: Colors.blue),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                          child: Text("Price",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(child: Text("Price: RM" + widget.book.price)),
                      ],
                    ),
                    Divider(color: Colors.blue),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                          child: Text("ISBN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(child: Text(widget.book.isbn)),
                      ],
                    ),
                    Divider(color: Colors.blue),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                          child: Text("Publisher",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                            child: Text("Publisher" + widget.book.publisher)),
                      ],
                    ),
                  ],
                )))));
  }
}
