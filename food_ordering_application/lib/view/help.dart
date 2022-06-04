import 'package:flutter/material.dart';

import '../model/constant.dart';

class Help extends StatefulWidget {
  const Help({Key key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Help'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Container(
          child: Card(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Contact Us',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      '+94713033790',
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      'foodx@gmail.com',
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
