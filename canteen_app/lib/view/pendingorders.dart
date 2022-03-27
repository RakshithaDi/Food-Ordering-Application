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
  bool status = true;
  String orderId = '';
  String date = '';
  String time = '';
  String name = '';
  String phoneNo = '';
  String email = '';
  String itemDescription = '';
  String price = '';
  int itemsIndex = 0;
  bool rightcontainer = true;
  bool loadDescription = false;

  void getOrderDetailsViaQrScanner(String orId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orId)
        .get()
        .then((DocumentSnapshot orderDetails) {
      if (orderDetails.exists) {
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
          date = formatDate;
          rightcontainer = false;
        });
      } else {
        print('print Error');
      }
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
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        primary: false,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("orders")
                              .where('Status', isEqualTo: 'Pending')
                              //  .orderBy('TimeStamp', descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                        MediaQuery.of(context).size.height / 13,
                                    child: Card(
                                      child: InkWell(
                                        onTap: () {
                                          String formatedDate;

                                          Timestamp timestamp =
                                              orders['TimeStamp'];
                                          DateTime dateTime =
                                              timestamp.toDate();
                                          String formatDate = DateFormat.yMMMd()
                                              .add_jm()
                                              .format(dateTime);

                                          setState(() {
                                            orderId = orders['OrderId'];
                                            name = orders['Name'];
                                            phoneNo = orders['PhoneNo'];
                                            email = orders['Email'];
                                            price = orders['Amount'];
                                            date = formatDate;
                                            rightcontainer = false;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  orders['OrderId'],
                                                  style: customTextStyle1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  orders['Name'],
                                                  style: customTextStyle1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
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
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
              rightcontainer == false
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              alignment: Alignment.center,
                              child: const Text(
                                'Order Description',
                                style: customTextStyle2,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Order ID:',
                                      style: customTextStyle1,
                                    ),
                                  ),
                                  Expanded(
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
                                      child: Text(
                                    'Name:',
                                    style: customTextStyle1,
                                  )),
                                  Expanded(
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
                                  const Expanded(
                                      child: Text(
                                    'Date',
                                    style: customTextStyle1,
                                  )),
                                  Expanded(
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
                                      child: Text(
                                    'Phone No:',
                                    style: customTextStyle1,
                                  )),
                                  Expanded(
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
                                    child: Text(
                                      'Email:',
                                      style: customTextStyle1,
                                    ),
                                  ),
                                  Expanded(
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
                                    child: Text(
                                      'Item Description:',
                                      style: customTextStyle1,
                                    ),
                                  ),
                                  Expanded(
                                    child: orderId != ''
                                        ? Card(
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              child:
                                                  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('orders')
                                                    .doc(orderId)
                                                    .collection('OrderItems')
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return const Text(
                                                        "Something went wrong");
                                                  }

                                                  if (snapshot.connectionState ==
                                                          ConnectionState
                                                              .waiting ||
                                                      !snapshot.hasData) {
                                                    return const SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  }

                                                  if (snapshot.hasData) {
                                                    return ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        QueryDocumentSnapshot
                                                            category = snapshot
                                                                .data!
                                                                .docs[index];

                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    category[
                                                                        'name'],
                                                                    style:
                                                                        customTextStyle1,
                                                                  ),
                                                                )),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      category[
                                                                              'quantity']
                                                                          .toString(),
                                                                      style:
                                                                          customTextStyle1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'Rs. ${category['price'].toString()}',
                                                                      style:
                                                                          customTextStyle1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
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
                                      child: Text(
                                    'Total Price:',
                                    style: customTextStyle1,
                                  )),
                                  Expanded(
                                    child: Text(
                                      price,
                                      style: customTextStyle1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 50, left: 50, top: 40),
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (orderId != '') {
                                      showAlertDialog(context);
                                    } else {
                                      print('orderId is null');
                                    }
                                  },
                                  child: status == true
                                      ? const Text(
                                          "Complete",
                                        )
                                      : const CircularProgressIndicator(
                                          backgroundColor: Colors.black38,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white))),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
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
              const VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
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
      onPressed: () async {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(orderId)
            .update({"Status": 'Collected'})
            .then((value) => print("Status Updated Successfully!"))
            .catchError((error) => print("Failed: $error"));
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
