import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/login.dart';
import 'package:food_ordering_application/constant.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kredbackgroundcolor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Image(
                      image: AssetImage('images/loadingLogo.png'),
                      height: 150.0,
                      width: 300.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 100, bottom: 30, right: 20, left: 20),
                    width: 250,
                    height: 10,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0XFFD8352C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.white)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Login.id);
                      },
                      child: Image(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage('images/getStartedButton.png'),
                        height: 150.0,
                        width: 300.0,
                      ),
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
