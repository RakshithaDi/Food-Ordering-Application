import 'package:flutter/material.dart';

import '../constant.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: SafeArea(
          child: ListView(
            children: [
              Text(
                'Menu',
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }
}
