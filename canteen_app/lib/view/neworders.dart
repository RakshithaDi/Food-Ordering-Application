import 'package:canteen_app/model/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  bool status = true;
  String orderId = '';
  String date = '';
  String time = '';
  String name = '';
  String phoneNo = '';
  String email = '';
  String itemDescription = '';
  String price = '';
  @override
  Widget build(BuildContext context) {
    return Container(
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
                          .where('Status', isEqualTo: 'New')
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
                              String formatDate =
                                  DateFormat.yMMMd().add_jm().format(dateTime);
                              date = formatDate;

                              orderId = orders['OrderId'];
                              name = orders['Name'];
                              phoneNo = orders['PhoneNo'];
                              email = orders['Email'];
                              itemDescription = orders['OrderId'];
                              price = orders['Amount'];

                              return Container(
                                height: MediaQuery.of(context).size.height / 13,
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      String formatedDate;

                                      Timestamp timestamp = orders['TimeStamp'];
                                      DateTime dateTime = timestamp.toDate();
                                      String formatDate = DateFormat.yMMMd()
                                          .add_jm()
                                          .format(dateTime);

                                      setState(() {
                                        orderId = orders['OrderId'];
                                        name = orders['Name'];
                                        phoneNo = orders['PhoneNo'];
                                        email = orders['Email'];
                                        itemDescription = orders['OrderId'];
                                        price = orders['Amount'];
                                        date = formatDate;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              orders['OrderId'],
                                              style: customTextStyle1,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              orders['Name'],
                                              style: customTextStyle1,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
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
          Expanded(
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
                      children: const [
                        Expanded(
                            child: Text(
                          'Item Description:',
                          style: customTextStyle1,
                        )),
                        Expanded(
                          child: Text(
                            'fsf',
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
                          'Price:',
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
                    margin: const EdgeInsets.only(right: 50, left: 50),
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
                        onPressed: () async {},
                        child: status == true
                            ? const Text(
                                "Processed",
                              )
                            : const CircularProgressIndicator(
                                backgroundColor: Colors.black38,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
