import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _hcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();

  double h = 0.0;
  double w = 0.0;
  double bf = 0.0;
  double jf = 0.0;
  double hf = 0.0;
  double pf = 0.0;

  String radioButtonItem = 'First';

  int _radioValueG = 1;
  int _radioValueA = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('LBM Calculator(Metric Unit)'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Text(
                  'Gender',
                  style: new TextStyle(fontSize: 15),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValueG,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'First';
                      _radioValueG = 1;
                    });
                  },
                ),
                Text(
                  'Male',
                  style: new TextStyle(fontSize: 15),
                ),
                Radio(
                  value: 2,
                  groupValue: _radioValueG,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Second';
                      _radioValueG = 2;
                    });
                  },
                ),
                Text(
                  'Female',
                  style: new TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Text(
                  'Age 14 or younger?',
                  style: new TextStyle(fontSize: 15),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValueA,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'First';
                      _radioValueA = 1;
                    });
                  },
                ),
                Text(
                  'Yes',
                  style: new TextStyle(fontSize: 15),
                ),
                Radio(
                  value: 2,
                  groupValue: _radioValueA,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Second';
                      _radioValueA = 2;
                    });
                  },
                ),
                Text(
                  'No',
                  style: new TextStyle(fontSize: 15),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Height (cm)",
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _hcontroller,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Weight (kg)",
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _wcontroller,
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: RaisedButton(
                  child: Text("Calculate"),
                  onPressed: _onPress,
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: RaisedButton(
                  child: Text("Clear"),
                  onPressed: _clear,
                )),
            Text("Boer Formula: $bf"),
            Text("James Formula: $jf"),
            Text("Hume Formula: $hf"),
            Text("Peter Formula: $pf"),
            
          ],
        ),
      ),
    );
  }

  void _onPress() {
    setState(() {
      if (_radioValueG == 1 && _radioValueA == 2) {
        h = double.parse(_hcontroller.text);
        w = double.parse(_wcontroller.text);

        bf = (0.407 * w) + (0.267 * h) - 19.2;
        jf = (1.1 * w) - (128 * (w / h * w / h));
        hf = (0.32810 * w) + (0.33929 * h) - 29.5336;
        pf = 0.00;
      } else {
        if (_radioValueG == 2 && _radioValueA == 2) {
          h = double.parse(_hcontroller.text);
          w = double.parse(_wcontroller.text);

          bf = (0.252 * w) + (0.473 * h) - 48.3;
          jf = (1.07 * w) - (148 * (w / h * w / h));
          hf = (0.29569 * w) + (0.41813 * h) - 43.2933;
          pf = 0.00;
        } else {
          if (_radioValueG == 1 || _radioValueG == 2 && _radioValueA == 1) {
            h = double.parse(_hcontroller.text);
            w = double.parse(_wcontroller.text);
            double x = pow(w, 0.6469);
            double y = pow(h, 0.7236);
            double ecv = 0.0215 * x * y;
            bf = 0.0;
            jf = 0.0;
            hf = 0.0;
            pf = 3.8 * ecv;
          }
        }
      }
    });
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  void _clear() {
    _hcontroller.clear();
    _wcontroller.clear();
  }
}
