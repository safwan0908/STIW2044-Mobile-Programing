import 'package:flutter/material.dart';
import 'package:mid_term/book.dart';
import 'package:mid_term/detailscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating/flutter_rating.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      home: Scaffold(
        body: Container(
          child: MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Book book;

  const MainScreen({Key key, this.book}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight = 0.00;
  double screenWidth = 0.00;
  String title = "Loading...";
  int starCount = 5;
  double rating = 0.00;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  _MainScreenState createState() => _MainScreenState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Books'),
      ),
      body: Column(children: [
        bookList == null
            ? Flexible(
                child: Container(
                    child: Center(
                        child: Text(title,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )))))
            : Flexible(
                child: GridView.count(
                crossAxisCount: 1,
                children: List.generate(bookList.length, (index) {
                  return Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                          child: InkWell(
                              onTap: () => _loadBookDetail(index),
                              child: Row(children: [
                                Container(
                                    height: screenHeight / 0.5,
                                    width: screenWidth / 3,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 2,
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Center(
                                        child: Text(
                                          bookList[index]['booktitle'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      StarRating(
                                        size: 14.5,
                                        rating: double.parse(
                                          bookList[index]['rating'],
                                        ),
                                        color: Colors.black,
                                        borderColor: Colors.grey,
                                        starCount: starCount,
                                        onRatingChanged: (rating) => setState(
                                          () {
                                            this.rating = rating;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Rating: " + bookList[index]['rating'],
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Author: " + bookList[index]['author'],
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Price: RM " + bookList[index]['price'],
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ]))
                              ]))));
                }),
              ))
      ]),
    );
  }

  void _loadBook() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          title = "No Book!";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["books"];
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _loadBookDetail(int index) {
    print(bookList[index]['booktitle']);
    Book book = new Book(
        bookid: bookList[index]['bookid'],
        booktitle: bookList[index]['booktitle'],
        author: bookList[index]['author'],
        price: bookList[index]['price'],
        description: bookList[index]['description'],
        rating: bookList[index]['rating'],
        publisher: bookList[index]['publisher'],
        isbn: bookList[index]['isbn'],
        cover: bookList[index]['cover']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(
                  book: book,
                )));
  }
}
