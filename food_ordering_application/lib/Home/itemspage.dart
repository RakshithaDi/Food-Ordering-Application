import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../cart.dart';
import '../constant.dart';
import '../item.dart';
import 'package:provider/provider.dart';

import 'cartpage.dart';

class Items extends StatefulWidget {
  int catergoryId;
  Items(this.catergoryId);
  @override
  _ItemsState createState() => _ItemsState(catergoryId);
}

class _ItemsState extends State<Items> {
  int categoryId;
  int quantity = 1;
  String name;
  String imgUrl;
  double price;

  _ItemsState(this.categoryId);
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Items'),
          backgroundColor: kredbackgroundcolor,
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => CartPage(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 5),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
                child: Text(
                  Cart.count.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
          ],
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

                  // if (snapshot.connectionState == ConnectionState.waiting ||
                  //     !snapshot.hasData) {
                  //   return CircularProgressIndicator();
                  // }

                  if (snapshot.hasData) {
                    print('has data in items');
                    return Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, index) {
                          QueryDocumentSnapshot recommend =
                              snapshot.data.docs[index];

                          price = double.parse(recommend['price']);
                          name = recommend['name'];
                          imgUrl = recommend['imgUrl'];

                          final List<Item> items = [
                            for (var i = 0; i < snapshot.data.docs.length; i++)
                              Item(name: name, price: price, imgUrl: imgUrl),
                          ];

                          return Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 15,
                                          left: 8,
                                          top: 8,
                                          bottom: 8),
                                      width: 100,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14)),
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            recommend['imgUrl'],
                                          ))),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 230,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: 8, top: 4),
                                                  child: Text(
                                                    recommend['name'],
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Card(
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 24,
                                                            color: Colors.red,
                                                          ),
                                                          onTap: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        //color: Colors.grey.shade200,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5,
                                                                right: 10,
                                                                left: 10),
                                                        child: Text(
                                                          '1',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 24,
                                                            color:
                                                                Colors.blueGrey,
                                                          ),
                                                          onTap: () {},
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width: 230,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    "M",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    child: Text(
                                                      "Total: RS.80",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 230,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    'Rs. ${recommend['price']}',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Container(
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors.white,
                                                        backgroundColor:
                                                            Color(0XFFD8352C),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            side: BorderSide(
                                                                color:
                                                                    kredbackgroundcolor)),
                                                      ),
                                                      onPressed: () {
                                                        cart.add(items[index]);
                                                      },
                                                      child:
                                                          Text('Add to Cart'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
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
    });
  }
}
