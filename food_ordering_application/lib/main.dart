import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/otp_setup.dart';
import 'package:food_ordering_application/Authentication/otp_verify.dart';

import 'Authentication/authscreen.dart';
import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'Home/account.dart';
import 'Home/home.dart';
import 'loading_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebasetest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AddUser.id,
      routes: {
        AddUser.id: (context) => AddUser('rdscorpi', 'ghkfdf', 12),
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
