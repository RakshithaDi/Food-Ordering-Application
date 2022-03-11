import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/orders.dart';
import 'package:food_ordering_application/Home/personalinfo.dart';
import 'package:get/get.dart';
import 'Authentication/login.dart';
import 'Authentication/otp_setup.dart';
import 'Authentication/otp_verify.dart';
import 'Authentication/signup.dart';
import 'Home/account.dart';
import 'cart.dart';
import 'firebase_options.dart';
import 'Home/home.dart';
import 'loading_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:provider/provider.dart';

String appState = '1';
StreamController<String> streamController = StreamController<String>();

void main() async {
  //initialze the application
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //run the application
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: FoodOrderingApp(),
  ));
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
    return GetMaterialApp(
      // initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup('0'),
        OtpSetup.id: (context) => OtpSetup(),
        OtpVerify.id: (context) => OtpVerify(0),
        Account.id: (context) => Account(),
        Home.id: (context) => Home(),
        OrderDetails.id: (context) => OrderDetails(),
        PersonalInfo.id: (context) => PersonalInfo(),
      },
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
    print(appStateValue);
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
    checkNetConnection();
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

      return LoadingScreen();
    }
  }

  Future<void> checkNetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('internet connected');
      }
    } on SocketException catch (_) {
      print('no internet connection');
      showAlertDialog('Internet Connection Required', context);
    }
  }
}

showAlertDialog(String message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert Box"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
