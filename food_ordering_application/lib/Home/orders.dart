import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
        title: Text('Check Out'),
        backgroundColor: kredbackgroundcolor,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 650,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('orders')
                      .where('Email', isEqualTo: userEmail)
                      .where('Status', isEqualTo: 'Pending')
                      .get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            QueryDocumentSnapshot orders =
                                snapshot.data.docs[index];

                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                            'Order #${orders['OrderId']}',
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Status : ${orders['Status']}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Total Amount:  Rs.${orders['Amount']}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
