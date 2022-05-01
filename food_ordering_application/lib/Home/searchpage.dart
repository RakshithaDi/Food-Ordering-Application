import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/itemspage.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

import '../cart.dart';
import '../constant.dart';
import '../item.dart';
import 'Itemdetails.dart';
import 'cartpage.dart';

class SearchItemsPage extends StatefulWidget {
  @override
  State<SearchItemsPage> createState() => _SearchItemsPage();
}

class _SearchItemsPage extends State<SearchItemsPage> {
  @override
  int categoryId;
  int quantity = 1;
  String name;

  String imgUrl;
  int prodId;
  double price;
  @override
  void initState() {
    super.initState();
    items.removeRange(0, items.length);
    getAllItems();
  }

  List<Item> items = [];
  void getAllItems() {
    FirebaseFirestore.instance
        .collection('items')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["id"]);
        items.add(Item(
            productId: doc["id"],
            name: doc["name"],
            price: double.parse(doc["price"]),
            imgUrl: doc["imgUrl"],
            quantity: 1));
      });
      print(items[9].name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Items'),
          backgroundColor: Sushi,
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
              height: MediaQuery.of(context).size.height - 90,
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('items').get(),
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
                          QueryDocumentSnapshot allproducts =
                              snapshot.data.docs[index];
                          prodId = allproducts['id'];
                          price = double.parse(allproducts['price']);
                          name = allproducts['name'];
                          imgUrl = allproducts['imgUrl'];

                          return Stack(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
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
                                              allproducts['imgUrl'],
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
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 8, top: 4),
                                                  child: Text(
                                                    allproducts['name'],
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   margin: EdgeInsets.only(top: 10),
                                          //   width: 230,
                                          //   child: Container(
                                          //     child: Text(
                                          //       "M",
                                          //       style: TextStyle(
                                          //           color: Colors.grey,
                                          //           fontSize: 14),
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            width: 230,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: Text(
                                                      'Rs. ${allproducts['price']}',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Container(
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: Colors.white,
                                                          backgroundColor:
                                                              Sushi,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          cart.add(
                                                              items[index]);
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
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ItemDetails(allproducts['id']),
                                    ),
                                  );
                                },
                              ),
                            ],
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Sushi,
          tooltip: 'Search for Food',
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchPage<Item>(
                onQueryUpdate: (s) => print(s),
                barTheme: ThemeData(
                  appBarTheme: AppBarTheme(
                    color: Sushi,
                  ),
                ),
                items: items,
                searchLabel: 'Search Food Items',
                suggestion: Center(
                  child: Text('Filter Food items by name'),
                ),
                failure: Center(
                  child: Text('No Item Found!'),
                ),
                filter: (items) => [
                  items.name,
                ],
                builder: (items) => Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                ItemDetails(items.productId),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: kbackgroundcolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  right: 15, left: 8, top: 8, bottom: 8),
                              width: 100,
                              height: 90,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                    items.imgUrl,
                                  ))),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 230,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 4),
                                        child: Text(
                                          items.name,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 230,
                                  child: Container(
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 230,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            'Rs. ${items.price}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor: Sushi,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                cart.add(items);
                                              },
                                              child: Text('Add to Cart'),
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
                    ),
                  ],
                ),
              ),
            );
          },
          child: Icon(Icons.search),
        ),
      );
    });
  }
}
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Search Page'),
//     ),
//     body: ListView.builder(
//       itemCount: people.length,
//       itemBuilder: (context, index) {
//         final Person person = people[index];
//         return ListTile(
//           title: Text(person.name),
//           subtitle: Text(person.surname),
//           trailing: Text('${person.age} yo'),
//         );
//       },
//     ),
