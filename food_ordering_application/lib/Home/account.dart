import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  static String id = 'account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
                        child: CircleAvatar(
                          radius: 70.0,
                          child: Image(
                            image: AssetImage('images/foodx.png'),
                            width: 40,
                          ),
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
                                Text(' rakshithadilshan1@gmail.com'),
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
                    onPressed: () {},
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
