import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../model/constant.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  bool ButtonStatus = true;
  String orderId = '';
  String date = '';
  String status = '';
  String time = '';
  String name = '';
  String phoneNo = '';
  String email = '';
  String itemDescription = '';
  String price = '';
  int itemsIndex = 0;
  bool rightcontainer = true;
  bool loadDescription = false;
  String payment = '';

  void getOrderDetailsViaQrScanner(String orId) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(orId)
        .get()
        .then((DocumentSnapshot orderDetails) {
      // if (orderDetails['Status'] == 'Pending') {
      // orderDetails.exists
      String formatedDate;

      Timestamp timestamp = orderDetails['TimeStamp'];
      DateTime dateTime = timestamp.toDate();
      String formatDate = DateFormat.yMMMd().add_jm().format(dateTime);

      setState(() {
        orderId = orderDetails['OrderId'];
        name = orderDetails['Name'];
        phoneNo = orderDetails['PhoneNo'];
        email = orderDetails['Email'];
        price = orderDetails['Amount'];
        status = orderDetails['Status'];
        payment = orderDetails['Payment'];
        date = formatDate;
        rightcontainer = false;
      });
      //  } else {
      //   print('Not in pending orders');
      //  }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Paid Orders',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: titleColor),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          child: SingleChildScrollView(
                            primary: false,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("orders")
                                  .where('Status', isEqualTo: 'Pending')
                                  .where('Payment', isEqualTo: 'Paid')
                                  //  .orderBy('TimeStamp', descending: true)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  //  return CircularProgressIndicator();
                                }

                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      QueryDocumentSnapshot orders =
                                          snapshot.data!.docs[index];
                                      String formatedDate;

                                      Timestamp timestamp = orders['TimeStamp'];
                                      DateTime dateTime = timestamp.toDate();
                                      String formatDate = DateFormat.yMMMd()
                                          .add_jm()
                                          .format(dateTime);
                                      date = formatDate;

                                      // orderId = orders['OrderId'];
                                      // name = orders['Name'];
                                      // phoneNo = orders['PhoneNo'];
                                      // email = orders['Email'];
                                      // price = orders['Amount'];

                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        child: Card(
                                          color: Colors.white.withOpacity(0.6),
                                          child: InkWell(
                                            onTap: () {
                                              String formatedDate;

                                              Timestamp timestamp =
                                                  orders['TimeStamp'];
                                              DateTime dateTime =
                                                  timestamp.toDate();
                                              String formatDate =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(dateTime);

                                              setState(() {
                                                orderId = orders['OrderId'];
                                                name = orders['Name'];
                                                phoneNo = orders['PhoneNo'];
                                                email = orders['Email'];
                                                price = orders['Amount'];
                                                date = formatDate;
                                                status = orders['Status'];
                                                rightcontainer = false;
                                                payment = orders['Payment'];
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      orders['OrderId'],
                                                      style: customTextStyle1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      orders['Name'],
                                                      style: customTextStyle1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      date,
                                                      style: customTextStyle1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Unpaid Orders',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: titleColor),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          child: SingleChildScrollView(
                            primary: false,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("orders")
                                  .where('Status', isEqualTo: 'Pending')
                                  .where('Payment', isEqualTo: 'Unpaid')
                                  //  .orderBy('TimeStamp', descending: true)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  //  return CircularProgressIndicator();
                                }

                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      QueryDocumentSnapshot orders =
                                          snapshot.data!.docs[index];
                                      String formatedDate;

                                      Timestamp timestamp = orders['TimeStamp'];
                                      DateTime dateTime = timestamp.toDate();
                                      String formatDate = DateFormat.yMMMd()
                                          .add_jm()
                                          .format(dateTime);
                                      date = formatDate;

                                      // orderId = orders['OrderId'];
                                      // name = orders['Name'];
                                      // phoneNo = orders['PhoneNo'];
                                      // email = orders['Email'];
                                      // price = orders['Amount'];

                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        child: Card(
                                          color: Colors.white.withOpacity(0.6),
                                          child: InkWell(
                                            onTap: () {
                                              String formatedDate;

                                              Timestamp timestamp =
                                                  orders['TimeStamp'];
                                              DateTime dateTime =
                                                  timestamp.toDate();
                                              String formatDate =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(dateTime);

                                              setState(() {
                                                orderId = orders['OrderId'];
                                                name = orders['Name'];
                                                phoneNo = orders['PhoneNo'];
                                                email = orders['Email'];
                                                price = orders['Amount'];
                                                date = formatDate;
                                                status = orders['Status'];
                                                rightcontainer = false;
                                                payment = orders['Payment'];
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      orders['OrderId'],
                                                      style: customTextStyle1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      orders['Name'],
                                                      style: customTextStyle1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      date,
                                                      style: customTextStyle1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              rightcontainer == false
                  ? Expanded(
                      child: Card(
                        elevation: 5,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                color: Colors.white.withOpacity(0.6),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 30, top: 10),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Order Description',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: titleColor),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white.withOpacity(0.6),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Order ID:',
                                                style: customTextStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                orderId,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Name:',
                                                  style: customTextStyle1,
                                                )),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                name,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Status',
                                                  style: customTextStyle1,
                                                )),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                status,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Date',
                                                style: customTextStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                date,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Phone No:',
                                                style: customTextStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                phoneNo,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Email:',
                                                style: customTextStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                email,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Item Description:',
                                                style: customTextStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: orderId != ''
                                                  ? Container(
                                                      child: StreamBuilder<
                                                          QuerySnapshot>(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'orders')
                                                            .doc(orderId)
                                                            .collection(
                                                                'OrderItems')
                                                            .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    QuerySnapshot>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return const Text(
                                                                "Something went wrong");
                                                          }

                                                          if (snapshot.connectionState ==
                                                                  ConnectionState
                                                                      .waiting ||
                                                              !snapshot
                                                                  .hasData) {
                                                            return const SizedBox(
                                                              height: 100,
                                                              width: 100,
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot
                                                              .hasData) {
                                                            return Card(
                                                              child: ListView
                                                                  .builder(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        index) {
                                                                  QueryDocumentSnapshot
                                                                      category =
                                                                      snapshot
                                                                          .data!
                                                                          .docs[index];

                                                                  return Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              category['name'],
                                                                              style: customTextStyle1,
                                                                            ),
                                                                          )),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                category['quantity'].toString(),
                                                                                style: customTextStyle1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Rs. ${category['price'].toString()}',
                                                                                style: customTextStyle1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          }
                                                          return const SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Payment:',
                                                  style: customTextStyle1,
                                                )),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                payment,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Total Price:',
                                                style: customTextStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                price,
                                                style: customTextStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              payment == 'Paid'
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          right: 50, left: 50, top: 40),
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Color(0xFFE59B747),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              side: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (orderId != '') {
                                              showAlertDialog(context);
                                            } else {
                                              print('orderId is null');
                                            }
                                          },
                                          child: ButtonStatus == true
                                              ? const Text(
                                                  "Complete",
                                                )
                                              : const CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.black38,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Colors.white))),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(
                                          right: 50, left: 50, top: 40),
                                      width: 160,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Color(0xFFE59B747),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              side: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (orderId != '') {
                                              showAlertDialog2(context);
                                            } else {
                                              print('orderId is null');
                                            }
                                          },
                                          child: ButtonStatus == true
                                              ? const Text(
                                                  "Paid & Complete",
                                                )
                                              : const CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.black38,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Colors.white))),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text(
                                'Select an Order',
                                style: TextStyle(
                                  color: titleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.touch_app_outlined,
                              size: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Text(
                            'Scan Order Via QR',
                            style: customTextStyle2,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: MobileScanner(
                              allowDuplicates: false,
                              onDetect: (barcode, args) {
                                final String? code = barcode.rawValue;
                                debugPrint('Barcode found! $code');
                                getOrderDetailsViaQrScanner(code.toString());
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        FirebaseFirestore.instance
            .collection("orders")
            .doc(orderId)
            .update({"Status": 'Collected'})
            .then((value) => print("Status Updated Successfully!"))
            .catchError((error) => print("Failed: $error"));

        setState(() {
          rightcontainer = true;
        });
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
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
      content: const Text("Are you sure you want to continue?"),
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

  showAlertDialog2(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        FirebaseFirestore.instance
            .collection("orders")
            .doc(orderId)
            .update({"Status": 'Collected', "Payment": 'Paid'})
            .then((value) => print("Status Updated Successfully!"))
            .catchError((error) => print("Failed: $error"));

        setState(() {
          rightcontainer = true;
        });
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
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
      content: const Text("Are you sure you want to continue?"),
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
}
