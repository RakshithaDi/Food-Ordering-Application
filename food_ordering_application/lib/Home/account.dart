import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/login.dart';
import 'package:food_ordering_application/constant.dart';
import 'package:food_ordering_application/loading_screen.dart';

import '../main.dart';

class Account extends StatefulWidget {
  static String id = 'account';
  @override
  _AccountState createState() => _AccountState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _AccountState extends State<Account> {
  String userEmail;

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.account_circle,
                          size: 110,
                          color: kredbackgroundcolor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                                Text(' NAR Dilshan'),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 20,
                                ),
                                Text(' rakshithad@gmail.com'),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                ),
                                Text(' 0766807668'),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(10),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text('Account Information'),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(10),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text('Your Orders'),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(10),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text('Settings'),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(10),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text('Help'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Send Feedback',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Reprot a Complaint',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Rate us on the Play Store',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(10),
                            onTap: () {
                              debugPrint('Card tapped.');
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.info_outline_rounded,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('About'),
                                ),
                                const SizedBox(
                                  height: 30,
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, right: 150, left: 150),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0XFFD8352C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.red)),
                    ),
                    onPressed: () async {
                      showAlertDialog(context);
                    },
                    child: Text('Log Out'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void logout() async {
  await FirebaseAuth.instance.signOut();
  streamController.add('2');
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "YES",
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.red,
      ),
    ),
    onPressed: () {
      logout();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoadingScreen()));
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "NO",
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Log Out"),
    content: Text("Are you sure you want to log out?"),
    actions: [
      cancelButton,
      continueButton,
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
