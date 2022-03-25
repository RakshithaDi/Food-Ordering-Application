import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'orders.dart';

class EachOrders extends StatefulWidget {
  String orderId;
  EachOrders(this.orderId);
  @override
  _EachOrdersState createState() => _EachOrdersState(this.orderId);
}

class _EachOrdersState extends State<EachOrders> {
  String orderId;
  _EachOrdersState(this.orderId);
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text(
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
            .update({
              "Status": 'Collected',
            })
            .then((value) => print("Status Updated Successfully!"))
            .catchError((error) => print("Failed: $error"));

        // Navigator.pop(context);
        // setState(() {
        //   Navigator.pushNamed(context, OrderDetails.id);
        // });
        // Navigator.of(context).popUntil((route) => route.isCurrent);
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {
          Navigator.pushReplacementNamed(context, OrderDetails.id);
        });
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
      // title: Text("Confirm"),
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
        title: Text('Order Details'),
        backgroundColor: greenTheme,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Order Id: $orderId",
                style: TextStyle(fontSize: 14, color: titleColor),
              ),
              margin: EdgeInsets.only(left: 12, top: 10, bottom: 5),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: orders.doc(orderId).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> orderDetails =
                      snapshot.data.data() as Map<String, dynamic>;
                  String formatedDate;

                  Timestamp timestamp = orderDetails['TimeStamp'];
                  DateTime dateTime = timestamp.toDate();
                  String formatDate =
                      DateFormat.yMMMd().add_jm().format(dateTime);
                  formatedDate = formatDate;

                  //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(2),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderId)
                          .collection('OrderItems')
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
                          print('has data in Order Items');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    QueryDocumentSnapshot orderItems =
                                        snapshot.data.docs[index];
                                    double quantityPrice =
                                        orderItems['quantity'] *
                                            orderItems['price'];

                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    orderItems['name'],
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        " Price: ",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        ' ${orderItems['quantity']} * ${orderItems['price']} ',
                                                        // ${orderItems['quantity'] * orderItems['price']}
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                    '= Rs.$quantityPrice',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Quantity:  ${orderItems['quantity']} ',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  color: kbackgroundcolor,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Text(
                                          'Time: ${formatedDate}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Text(
                                          'Total Amount: Rs.${orderDetails['Amount']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Text(
                                          'Status: ${orderDetails['Status']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      orderDetails['Status'] == 'Pending'
                                          ? Container(
                                              margin: EdgeInsets.only(top: 20),
                                              child: SizedBox(
                                                height: 50,
                                                width: 150,
                                                child: Card(
                                                  elevation: 4,
                                                  color: titleColor,
                                                  child: InkWell(
                                                    onTap: () {
                                                      showAlertDialog(context);
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        'Collected',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return Container(
                          color: kbackgroundcolor,
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  );
                }

                return Text("loading");
              },
            ),
          ],
        ),
      ),
    );
  }
}
