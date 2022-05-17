import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

import '../model/cart.dart';
import 'package:food_ordering_application/model/constant.dart';
import 'package:food_ordering_application/model/item.dart';
import 'Itemdetails.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({Key key}) : super(key: key);

  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  @override
  void initState() {
    super.initState();
    getAllItems();
    items.removeRange(0, items.length);
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
        body: Container(
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.red,
              size: 35,
            ),
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
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                                        BorderRadius.circular(
                                                            5),
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
          ),
        ),
      );
    });
  }
}
