import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/otp_setup.dart';
import 'package:food_ordering_application/Authentication/otp_verify.dart';
import 'package:food_ordering_application/registeruser.dart';
// Import the generated file
import 'firebase_options.dart';

import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'Home/account.dart';
import 'Home/home.dart';
import 'loading_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

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
    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return MaterialApp(
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup(),
        OtpSetup.id: (context) => OtpSetup(),
        OtpVerify.id: (context) => OtpVerify(),
        Account.id: (context) => Account(),
        Home.id: (context) => Home(),
      },
    );
  }
}
