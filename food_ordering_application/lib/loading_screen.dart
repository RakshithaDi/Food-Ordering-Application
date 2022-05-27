import 'package:flutter/material.dart';
import 'package:food_ordering_application/view/login.dart';
import 'package:food_ordering_application/model/constant.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Sushi,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                          color: Colors.white,
                          image: AssetImage('images/canteen logo.png'),
                          height: 300.0,
                          width: 350.0,
                        ),
                      ),
                      Container(
                        child: Image(
                          color: Colors.white,
                          image: AssetImage('images/newLogofoodx.png'),
                          height: 100.0,
                          width: 300.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
