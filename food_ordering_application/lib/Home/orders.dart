import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/account.dart';
import 'package:food_ordering_application/Home/home.dart';
import 'package:food_ordering_application/Home/orderdetails.dart';

import '../constant.dart';

class OrderDetails extends StatefulWidget {
  static String id = 'OrderDetails';
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String userEmail;
  int pendingOrderslength;
  int collectedOrderslength;
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

  void CheckPendingOrders() async {
    await FirebaseFirestore.instance
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

  showAlertDialog(BuildContext context, String orderId) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () async {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(orderId)
            .update({
              "Status": 'Collected',
            })
            .then((value) => print("Status Updated Successfully!"))
            .catchError((error) => print("Failed: $error"));

        Navigator.pop(context);
        setState(() {
          Navigator.pushReplacementNamed(context, OrderDetails.id);
        });

        // Navigator.pop(context);
        // setState(() {
        //   Navigator.pushNamed(context, OrderDetails.id);
        // });
        // Navigator.of(context).popUntil((route) => route.isCurrent);
      },
    );
    Widget cancelButton = TextButton(
      child: Text(
        "No",
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
      //title: Text("Confirm"),
      content: Text("Did You collect your Order?"),
      actions: [
        continueButton,
        cancelButton,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Orders'),
        backgroundColor: greenTheme,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => Account(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: collectedOrderslength != 0 || pendingOrderslength != 0
            ? Container(
                child: Column(
                  children: [
                    pendingOrderslength != 0
                        ? Container(
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
                          )
                        : Container(),
                    pendingOrderslength != 0
                        ? Container(
                            margin: EdgeInsets.all(2),
                            child: FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('Email', isEqualTo: userEmail)
                                  .where('Status', isEqualTo: 'Pending')
                                  .orderBy('OrderId', descending: true)
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
                                        height: collectedOrderslength == 0
                                            ? 640
                                            : 350,
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
                                                                    color:
                                                                        titleColor,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        String
                                                                            orderId =
                                                                            orders['OrderId'];
                                                                        showAlertDialog(
                                                                            context,
                                                                            orderId);
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Collected',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
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
                                    child: CircularProgressIndicator(
                                      color: titleColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Center(
                            //         child: Icon(
                            //       Icons.downloading_rounded,
                            //       size: 100,
                            //       color: Colors.red,
                            //     )),
                            //     SizedBox(
                            //       height: 10,
                            //     ),
                            //     Center(
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(top: 10),
                            //         child: Text(
                            //           'No pending orders!',
                            //           style: TextStyle(
                            //               fontSize: 16, color: Colors.grey),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            ),
                    collectedOrderslength != 0
                        ? Container(
                            alignment: Alignment.topLeft,
                            height: 30,
                            child: Text(
                              'Collected Orders',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10, left: 15),
                          )
                        : Container(),
                    collectedOrderslength != 0
                        ? Container(
                            child: FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('Email', isEqualTo: userEmail)
                                  .where('Status', isEqualTo: 'Collected')
                                  .orderBy('OrderId', descending: true)
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
                                        height: pendingOrderslength == 0
                                            ? 650
                                            : 250,
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
                                    child: CircularProgressIndicator(
                                      color: titleColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
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
