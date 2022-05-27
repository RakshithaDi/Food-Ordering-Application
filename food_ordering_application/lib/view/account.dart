import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/view/login.dart';
import 'package:food_ordering_application/view/changepassword.dart';
import 'package:food_ordering_application/view/personalinfo.dart';
import 'package:food_ordering_application/view/voteforfood.dart';
import 'package:food_ordering_application/model//constant.dart';
import 'package:food_ordering_application/view/login.dart';
import 'package:food_ordering_application/view/changepassword.dart';
import 'package:food_ordering_application/view/personalinfo.dart';
import 'package:food_ordering_application/loading_screen.dart';

import '../main.dart';
import 'complaint.dart';
import 'notifications.dart';
import 'orders.dart';

class Account extends StatefulWidget {
  static String id = 'account';
  @override
  _AccountState createState() => _AccountState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _AccountState extends State<Account> {
  String userEmail;
  String name;
  String phoneNo;

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
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Account'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.account_circle,
                            size: 110,
                            color: titleColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('userprofile')
                                  .doc(userEmail)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  // return CircularProgressIndicator();
                                }

                                if (snapshot.hasData) {
                                  Map<String, dynamic> userData = snapshot.data
                                      .data() as Map<String, dynamic>;
                                  return Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 20,
                                            ),
                                            Text(
                                                '${userData['fname']} ${userData['lname']}'),
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
                                            Text('$userEmail'),
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
                                            Text('${userData['mobileno']}'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: titleColor,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
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
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => PersonalInfo(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3, child: Text('Personal Information')),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ),
                            ],
                          ),
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
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => OrdersHome(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 20),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text('Your Orders')),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ),
                            ],
                          ),
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
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ChangePassword(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 20),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text('Change Password')),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ),
                            ],
                          ),
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
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                NotificationPage(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 20),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text('Notifications')),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ),
                            ],
                          ),
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
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('Help'),
                              ),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ),
                            ],
                          ),
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
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Complaints(),
                        ),
                      );
                    },
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
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => VoteFood(),
                        ),
                      );
                    },
                    child: Text(
                      'Vote for Food     ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Rate us on the Play Store',
                  //     style: TextStyle(
                  //       color: Colors.grey[600],
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
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
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Sushi,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                    onPressed: () async {
                      showAlertDialog(context);
                    },
                    child: Text('Log Out'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void logout() async {
  await FirebaseAuth.instance.signOut();
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
      // Navigator.of(context, rootNavigator: true).pop();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoadingScreen()));
      Navigator.pushNamedAndRemoveUntil(
          context, LoadingScreen.id, (route) => false);
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
