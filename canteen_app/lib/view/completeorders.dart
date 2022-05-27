import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/constant.dart';

class CompleteOrders extends StatefulWidget {
  const CompleteOrders({Key? key}) : super(key: key);

  @override
  _CompleteOrdersState createState() => _CompleteOrdersState();
}

class _CompleteOrdersState extends State<CompleteOrders> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ListView(
                      children: [
                        SingleChildScrollView(
                          primary: false,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("orders")
                                .where('Status', isEqualTo: 'Collected')
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
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
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
              ),
              rightcontainer == false
                  ? Expanded(
                      child: Card(
                        elevation: 5,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: ListView(
                            children: [
                              Card(
                                color: Colors.white.withOpacity(0.6),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20, top: 10),
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    children: [
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
                                                        margin:
                                                            EdgeInsets.all(10),
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
                                                              return ListView
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
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 10),
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
                                    ],
                                  ),
                                ),
                              )
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
            ],
          ),
        ),
      ),
    );
  }
}
