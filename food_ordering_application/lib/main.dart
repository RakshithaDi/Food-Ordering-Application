import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/otp_setup.dart';
import 'package:food_ordering_application/Authentication/otp_verify.dart';
import 'package:food_ordering_application/registeruser.dart';
import 'package:get/get.dart';
// Import the generated file
import 'firebase_options.dart';

import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'Home/account.dart';
import 'Home/home.dart';
import 'loading_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String appState = '1';
StreamController<String> streamController = StreamController<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.userChanges().listen((User user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });
    return MaterialApp(
      // initialRoute: LoadingScreen.id,
      // routes: {
      //   LoadingScreen.id: (context) => LoadingScreen(),
      //   Login.id: (context) => Login(),
      //   Signup.id: (context) => Signup(0),
      //   OtpSetup.id: (context) => OtpSetup(),
      //   OtpVerify.id: (context) => OtpVerify(0),
      //   Account.id: (context) => Account(),
      //   Home.id: (context) => Home(),
      // },
      home: ViewController(streamController.stream),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewController extends StatefulWidget {
  ViewController(this.stream);
  final Stream<String> stream;

  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  void setAppState(String appStateValue) {
    setState(() {
      appState = appStateValue;
    });
  }

  @override
  void initState() {
    super.initState();

    widget.stream.listen((appStateValue) {
      setAppState(appStateValue);
    });

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        setAppState('2');
      } else {
        print('User is signed in!');

        setAppState('0');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (appState == '0') {
      print(appState);
      return Home();
    } else if (appState == '1') {
      return Scaffold(
        body: Container(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      );
    } else if (appState == '2') {
      setState(() {
        appState = '2';
      });
      print(appState);

      return LoadingScreen();
    }
    print(appState);
    // else {
    //   print(appState);
    //   return RideView(appState);
    // }
  }
}
