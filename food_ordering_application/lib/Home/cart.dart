import 'package:flutter/material.dart';

import '../constant.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: SafeArea(
          child: ListView(
            children: [
              Text(
                'Cart',
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }
}
