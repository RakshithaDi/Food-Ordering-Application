import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../cart.dart';
import '../constant.dart';
import 'orderdetails.dart';

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
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Cart.noificationCount == 0
                ? Center(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.hourglass_empty,
                            size: 100,
                            color: titleColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No notifications yet!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .where('Email', isEqualTo: userEmail)
                          .where('Status', isEqualTo: 'Pending')
                          .orderBy('OrderId', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    String formatedDate;

                                    Timestamp timestamp = orders['TimeStamp'];
                                    DateTime dateTime = timestamp.toDate();
                                    String formatDate = DateFormat.yMMMd()
                                        .add_jm()
                                        .format(dateTime);
                                    formatedDate = formatDate;

                                    return Card(
                                      elevation: 4,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  EachOrders(orders['OrderId']),
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
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Card(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .border_color,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              Text(
                                                                '${orders['OrderId']}',
                                                                maxLines: 2,
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        color: Sushi,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        formatedDate,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey[600]),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7),
                                                child: Row(
                                                  children: [
                                                    Container(
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
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.only(top: 7),
                                              //   child: Text(
                                              //     'Total Amount:  Rs.${orders['Amount']}',
                                              //     style: TextStyle(fontSize: 14),
                                              //   ),
                                              // ),
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
                              child: CircularProgressIndicator(
                                color: titleColor,
                              ),
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
