import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import 'account.dart';
import 'orderdetails.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  String userEmail;
  int paidOrderslength;
  int unpaidOrderslength;

  @override
  void initState() {
    super.initState();

    getUserMail();
    CheckPaidPendingOrders();
    CheckUnpaidPendingOrders();
  }

  void getUserMail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  void CheckPaidPendingOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: userEmail)
        .where('Status', whereIn: ['Pending', 'New'])
        .where('Payment', isEqualTo: 'Paid')
        .get()
        .then((documentSnapshot) {
          if (documentSnapshot.size == 0) {
            setState(() {
              paidOrderslength = 0;
            });
          } else {
            setState(() {
              paidOrderslength = documentSnapshot.size;
            });
          }
          print('Pending paid Orders length:${documentSnapshot.size}');
        });
  }

  void CheckUnpaidPendingOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: userEmail)
        .where('Status', whereIn: ['Pending', 'New'])
        .where('Payment', isEqualTo: 'Unpaid')
        .get()
        .then((documentSnapshot) {
          if (documentSnapshot.size == 0) {
            setState(() {
              unpaidOrderslength = 0;
            });
          } else {
            setState(() {
              unpaidOrderslength = documentSnapshot.size;
            });
          }
          print('Pending unpaid Orders length:${documentSnapshot.size}');
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

        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          Navigator.of(context).popUntil((route) => route.isCurrent);
        });

        // Navigator.pop(context);
        // setState(() {
        //   Navigator.pushNamed(context, OrderDetails.id);
        // });
        //
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
      body: SafeArea(
        child: unpaidOrderslength != 0 || paidOrderslength != 0
            ? Container(
                child: Column(
                  children: [
                    paidOrderslength != 0
                        ? Container(
                            height: 20,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Paid Orders',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10, left: 15),
                          )
                        : Container(),
                    paidOrderslength != 0
                        ? Container(
                            color: Colors.white.withOpacity(0.7),
                            margin: EdgeInsets.all(2),
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('Email', isEqualTo: userEmail)
                                  .where('Status', whereIn: ['Pending', 'New'])
                                  .where('Payment', isEqualTo: 'Paid')
                                  .orderBy('TimeStamp', descending: true)
                                  .snapshots(),
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
                                        margin: EdgeInsets.only(top: 5),
                                        height: unpaidOrderslength == 0
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.37
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            QueryDocumentSnapshot orders =
                                                snapshot.data.docs[index];
                                            String formatedDate;

                                            Timestamp timestamp =
                                                orders['TimeStamp'];
                                            DateTime dateTime =
                                                timestamp.toDate();
                                            String formatDate =
                                                DateFormat.yMMMd()
                                                    .add_jm()
                                                    .format(dateTime);
                                            formatedDate = formatDate;

                                            return Column(
                                              children: [
                                                Card(
                                                  elevation: 2,
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
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: <Widget>[
                                                              Card(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .border_color,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '${orders['OrderId']}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                color: Sushi,
                                                              ),
                                                              // Expanded(
                                                              //   flex: 3,
                                                              //   child:
                                                              //       Container(
                                                              //     alignment:
                                                              //         Alignment
                                                              //             .topRight,
                                                              //     child: orders['Status'] ==
                                                              //             'New'
                                                              //         ? Text(
                                                              //             "Status : Pending",
                                                              //             textAlign:
                                                              //                 TextAlign.right,
                                                              //             style:
                                                              //                 TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                              //           )
                                                              //         : Text(
                                                              //             "Status : ${orders['Status']}",
                                                              //             style:
                                                              //                 TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                              //           ),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 5,
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                  formatedDate,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5,
                                                                    left: 5,
                                                                    bottom: 7),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    'Total Amount:  Rs.${orders['Amount']}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                // Expanded(
                                                                //   flex: 1,
                                                                //   child:
                                                                //       Container(
                                                                //     alignment:
                                                                //         Alignment
                                                                //             .topRight,
                                                                //     child:
                                                                //         SizedBox(
                                                                //       height:
                                                                //           40,
                                                                //       width:
                                                                //           100,
                                                                //       child:
                                                                //           Card(
                                                                //         elevation:
                                                                //             4,
                                                                //         color:
                                                                //             titleColor,
                                                                //         child:
                                                                //             InkWell(
                                                                //           onTap:
                                                                //               () {
                                                                //             String orderId = orders['OrderId'];
                                                                //             showAlertDialog(context, orderId);
                                                                //           },
                                                                //           child:
                                                                //               Center(
                                                                //             child: Text(
                                                                //               'Collected',
                                                                //               style: TextStyle(color: Colors.white),
                                                                //             ),
                                                                //           ),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
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
                        : Container(),
                    unpaidOrderslength != 0
                        ? Container(
                            alignment: Alignment.topLeft,
                            height: 20,
                            child: Text(
                              'Unpaid Orders',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10, left: 15),
                          )
                        : Container(),
                    unpaidOrderslength != 0
                        ? Container(
                            color: Colors.white.withOpacity(0.7),
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('Email', isEqualTo: userEmail)
                                  .where('Status', whereIn: ['Pending', 'New'])
                                  .where('Payment', isEqualTo: 'Unpaid')
                                  .orderBy('TimeStamp', descending: true)
                                  .snapshots(),
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
                                        margin: EdgeInsets.only(top: 5),
                                        height: paidOrderslength == 0
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.37
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.6,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            QueryDocumentSnapshot orders =
                                                snapshot.data.docs[index];
                                            String formatedDate;

                                            Timestamp timestamp =
                                                orders['TimeStamp'];
                                            DateTime dateTime =
                                                timestamp.toDate();
                                            String formatDate =
                                                DateFormat.yMMMd()
                                                    .add_jm()
                                                    .format(dateTime);
                                            formatedDate = formatDate;

                                            return Column(
                                              children: [
                                                Card(
                                                  elevation: 2,
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
                                                      margin: EdgeInsets.all(5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Card(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .border_color,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        Text(
                                                                          '${orders['OrderId']}',
                                                                          maxLines:
                                                                              2,
                                                                          softWrap:
                                                                              true,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                                // Expanded(
                                                                //   flex: 3,
                                                                //   child:
                                                                //       Container(
                                                                //     child: orders['Status'] ==
                                                                //             'New'
                                                                //         ? Text(
                                                                //             "Status : Pending",
                                                                //             textAlign: TextAlign.right,
                                                                //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                //           )
                                                                //         : Text(
                                                                //             "Status : ${orders['Status']}",
                                                                //             textAlign: TextAlign.right,
                                                                //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                //           ),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 5,
                                                                  top: 5,
                                                                ),
                                                                child: Text(
                                                                  formatedDate,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                  child: Text(
                                                                    'Total Amount:  Rs.${orders['Amount']}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child:
                                                              //       Container(
                                                              //     alignment:
                                                              //         Alignment
                                                              //             .topRight,
                                                              //     child:
                                                              //         SizedBox(
                                                              //       height: 40,
                                                              //       width: 100,
                                                              //       child: Card(
                                                              //         elevation:
                                                              //             4,
                                                              //         color:
                                                              //             titleColor,
                                                              //         child:
                                                              //             InkWell(
                                                              //           onTap:
                                                              //               () {
                                                              //             String
                                                              //                 orderId =
                                                              //                 orders['OrderId'];
                                                              //             showAlertDialog(
                                                              //                 context,
                                                              //                 orderId);
                                                              //           },
                                                              //           child:
                                                              //               Center(
                                                              //             child:
                                                              //                 Text(
                                                              //               'Collected',
                                                              //               style:
                                                              //                   TextStyle(color: Colors.white),
                                                              //             ),
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     ),
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                        ],
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
                      color: titleColor,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'You have no orders yet!',
                          style: TextStyle(fontSize: 16, color: titleColor),
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
