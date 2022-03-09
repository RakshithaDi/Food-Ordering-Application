import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/orderdetails.dart';

import '../constant.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String userEmail;
  int pendingOrderslength;
  int deliveredOrderslength;
  @override
  void initState() {
    super.initState();

    getUserMail();
    CheckPendingOrders();
    CheckDeliveredOrders();
  }

  void getUserMail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  void CheckPendingOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: userEmail)
        .where('Status', isEqualTo: 'Pending')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.size == 0) {
        setState(() {
          pendingOrderslength = 0;
        });
      } else {
        setState(() {
          pendingOrderslength = documentSnapshot.size;
        });
      }
      print('Pending Orders length:${documentSnapshot.size}');
    });
  }

  void CheckDeliveredOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: userEmail)
        .where('Status', isEqualTo: 'Delivered')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.size == 0) {
        setState(() {
          deliveredOrderslength = 0;
        });
      } else {
        setState(() {
          deliveredOrderslength = documentSnapshot.size;
        });
      }
      print('Delivered Orders length:${documentSnapshot.size}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Orders'),
        backgroundColor: kredbackgroundcolor,
      ),
      body: SafeArea(
        child: deliveredOrderslength != 0 || pendingOrderslength != 0
            ? Container(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Pending Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 15),
                    ),
                    pendingOrderslength != 0
                        ? Container(
                            margin: EdgeInsets.all(2),
                            child: FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('Email', isEqualTo: userEmail)
                                  .where('Status', isEqualTo: 'Pending')
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 350,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            QueryDocumentSnapshot orders =
                                                snapshot.data.docs[index];

                                            return Card(
                                              elevation: 3,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          EachOrders(orders[
                                                              'OrderId']),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                child: Text(
                                                                  '#${orders['OrderId']}',
                                                                  maxLines: 2,
                                                                  softWrap:
                                                                      true,
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
                                                                    fontSize:
                                                                        14,
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
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${orders['Date']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${orders['Time']}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                'Total Amount:  Rs.${orders['Amount']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: SizedBox(
                                                                  height: 40,
                                                                  width: 100,
                                                                  child: Card(
                                                                    elevation:
                                                                        4,
                                                                    color: Colors
                                                                        .yellow,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Recieved',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
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

                                return SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
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
                                  color: Colors.red,
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'No pending orders!',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 30,
                      child: Text(
                        'Delivered Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 15),
                    ),
                    deliveredOrderslength != 0
                        ? Container(
                            child: FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('Email', isEqualTo: userEmail)
                                  .where('Status', isEqualTo: 'Delivered')
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            QueryDocumentSnapshot orders =
                                                snapshot.data.docs[index];

                                            return Card(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          EachOrders(orders[
                                                              'OrderId']),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                child: Text(
                                                                  '#${orders['OrderId']}',
                                                                  maxLines: 2,
                                                                  softWrap:
                                                                      true,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
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
                                                                    fontSize:
                                                                        14,
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
                                                            const EdgeInsets
                                                                .only(top: 7),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${orders['Date']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${orders['Time']}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 7),
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
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Container(
                              child: Column(
                                children: [
                                  Center(
                                      child: Icon(
                                    Icons.downloading_rounded,
                                    size: 100,
                                    color: Colors.red,
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'No delivered orders!',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
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
                      color: Colors.red,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'You have no orders yet!',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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
