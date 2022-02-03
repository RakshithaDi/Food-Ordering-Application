import 'package:flutter/material.dart';

import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'loading_screen.dart';

void main() => runApp(FoodOrderingApp());

class FoodOrderingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup(),
      },
    );
  }
}
