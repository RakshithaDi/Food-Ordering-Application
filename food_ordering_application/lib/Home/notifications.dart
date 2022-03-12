import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/orders.dart';

import '../cart.dart';
import '../constant.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  String time;
  String userEmail;

  @override
  void initState() {
    super.initState();

    getUserMail();
  }

  void getUserMail() {
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
        title: Text('Notifications'),
        backgroundColor: kredbackgroundcolor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Cart.noificationCount == 0
            //     ? Container(
            //         child: Column(
            //           children: [
            //             Center(
            //                 child: Icon(
            //               Icons.report_gmailerrorred_outlined,
            //               size: 100,
            //               color: Colors.red,
            //             )),
            //             SizedBox(
            //               height: 20,
            //             ),
            //             Center(
            //               child: Text(
            //                 'No notifications yet!',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            Container(
              margin: EdgeInsets.only(top: 10),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('orders')
                    .where('Email', isEqualTo: userEmail)
                    .where('Status', isEqualTo: 'Pending')
                    .orderBy('OrderId', descending: true)
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  //
                  // if (snapshot.connectionState == ConnectionState.waiting ||
                  //     !snapshot.hasData) {
                  //   return CircularProgressIndicator();
                  // }

                  if (snapshot.hasData) {
                    print('has data in orders');
                    return Column(
                      children: [
                        Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, index) {
                              QueryDocumentSnapshot orders =
                                  snapshot.data.docs[index];

                              return Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            OrderDetails(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    '#${orders['OrderId']}',
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${orders['Date']}',
                                                  textAlign: TextAlign.right,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                    child: orders['Ready'] ==
                                                            'no'
                                                        ? Text(
                                                            'Your order is Processing!',
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            'Your order is Ready! Come and collect',
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${orders['Time']}',
                                                  textAlign: TextAlign.right,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Total Amount:  Rs.${orders['Amount']}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
