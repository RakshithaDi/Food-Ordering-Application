import 'package:canteen_app/view/createaccounts.dart';
import 'package:canteen_app/view/home.dart';
import 'package:canteen_app/view/login.dart';
import 'package:canteen_app/view/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'model/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Canteen Management Application',
        // theme: ThemeData(
        //   textTheme: GoogleFonts.latoTextTheme(
        //     Theme.of(context).textTheme,
        //   ),
        // ),
        //  home: Login(),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          Login.id: (context) => Login(),
          MyHomePage.id: (context) => MyHomePage(),
          ResetPassword.id: (context) => ResetPassword(),
          CreateAccounts.id: (context) => CreateAccounts(),
          // Emergency.id: (context) => Emergency(),
          // Complaints.id: (context) => Complaints(),
          // InitializeTrip.id: (context) => InitializeTrip(),
          // Partial.id: (context) => Partial(),
          // AddBusOwner.id: (context) => AddBusOwner(),
        });
  }
}
