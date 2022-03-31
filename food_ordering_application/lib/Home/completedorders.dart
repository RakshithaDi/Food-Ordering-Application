import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import 'account.dart';
import 'orderdetails.dart';
import 'penidingcollectedboth.dart';

class completedOrders extends StatefulWidget {
  const completedOrders({Key key}) : super(key: key);

  @override
  _completedOrdersState createState() => _completedOrdersState();
}

class _completedOrdersState extends State<completedOrders> {
  String userEmail;
  int pendingOrderslength;
  int collectedOrderslength;
  @override
  void initState() {
    super.initState();

    getUserMail();
    CheckDeliveredOrders();
  }

  void getUserMail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  void CheckDeliveredOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: userEmail)
        .where('Status', isEqualTo: 'Collected')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.size == 0) {
        setState(() {
          collectedOrderslength = 0;
        });
      } else {
        setState(() {
          collectedOrderslength = documentSnapshot.size;
        });
      }
      print('Collected Orders length:${documentSnapshot.size}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            collectedOrderslength != 0
                ? Container(
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('orders')
                          .where('Email', isEqualTo: userEmail)
                          .where('Status', isEqualTo: 'Collected')
                          .orderBy('TimeStamp', descending: true)
                          .get(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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

                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Card(
                                            elevation: 5,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        EachOrders(
                                                            orders['OrderId']),
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
                                                          const EdgeInsets.only(
                                                              top: 2),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              child: Text(
                                                                '#${orders['OrderId']}',
                                                                maxLines: 2,
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "Status : ${orders['Status']}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            child: Text(
                                                              formatedDate,
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Total Amount:  Rs.${orders['Amount']}',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
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
                      },
                    ),
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Icon(
                          Icons.downloading_rounded,
                          size: 100,
                          color: titleColor,
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'No completed Orders yet!',
                              style: TextStyle(fontSize: 16, color: titleColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
