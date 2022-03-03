import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Items extends StatefulWidget {
  int catergoryId;
  Items(this.catergoryId);
  @override
  _ItemsState createState() => _ItemsState(catergoryId);
}

class _ItemsState extends State<Items> {
  int categoryId;
  _ItemsState(this.categoryId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Items'),
        backgroundColor: kredbackgroundcolor,
      ),
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Container(
            height: 650,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('items')
                  .where('categoryId', isEqualTo: categoryId)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  print('has data in items');
                  return Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,

                      // ignore: missing_return
                      itemBuilder: (BuildContext context, index) {
                        QueryDocumentSnapshot recommend =
                            snapshot.data.docs[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 0,
                          ),
                          child: Card(
                            elevation: 5,
                            child: new InkWell(
                              onTap: () {
                                print("tapped");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, right: 5, left: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: double.infinity,
                                          child: Image.network(
                                            recommend['imgUrl'],
                                            alignment: Alignment.topLeft,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            recommend['name'],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Rs. ${recommend['price']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
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
                  );
                }

                return Container(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
