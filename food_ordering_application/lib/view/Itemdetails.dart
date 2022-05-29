import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/view/cartpage.dart';
import 'package:food_ordering_application/view/searchpage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../model/cart.dart';
import 'package:food_ordering_application/model/constant.dart';
import 'package:food_ordering_application/model/item.dart';

String docName;

class ItemDetails extends StatefulWidget {
  int productId;
  ItemDetails(this.productId);

  @override
  _ItemDetailsState createState() => _ItemDetailsState(this.productId);
}

class _ItemDetailsState extends State<ItemDetails> {
  int productId;
  int quantity = 1;
  double price;
  String imgUrl;
  String name;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
  }

  String rateConditions(double rate) {
    if (rate <= 1) {
      return '1.5';
    } else if (rate > 1 && rate <= 3) {
      return '2.5';
    } else if (rate > 3 && rate <= 5) {
      return '3.5';
    } else if (rate > 5 && rate <= 7) {
      return '4.0';
    } else {
      return '5.0';
    }
  }

  _ItemDetailsState(this.productId);
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Item'),
          backgroundColor: Sushi,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 34,
                ),
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SearchItemsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('items')
                          .where('id', isEqualTo: productId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          //  return CircularProgressIndicator();
                        }
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              docName = document.id;
                              print(docName);
                              price = double.parse(data['price']);
                              name = data['name'];
                              imgUrl = data['imgUrl'];

                              items = [
                                Item(
                                    name: name,
                                    price: price,
                                    imgUrl: imgUrl,
                                    quantity: quantity),
                              ];
                              return Container(
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      child: InkWell(
                                        child: Container(
                                          width: double.maxFinite,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5,
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            child:
                                                Image.network(data['imgUrl']),
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  data['name'],
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      color: titleColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              subtitle: Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Text(data['description'],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: titleColor,
                                                    )),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 18, bottom: 10),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  'Rating:${rateConditions(data['rating'])}',
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      color: titleColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 18),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  'Rs.${data['price']}.00',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: titleColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 18, top: 10),
                                              child: Ratings(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }
                        return SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: titleColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: MaterialButton(
                              onPressed: () {
                                cart.add(items[0]);
                              },
                              color: Sushi,
                              textColor: Colors.white,
                              elevation: 0.2,
                              child: Text("Add to Cart")),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, CartPage.id);
                          },
                          icon: Icon(
                            Icons.shopping_cart_rounded,
                            color: Sushi,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 5),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.yellow),
                          child: Text(
                            Cart.count.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Ratings extends StatefulWidget {
  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  int _ratingBarMode = 1;
  double _rating = 2.0;
  bool _isVertical = false;
  double _initialRating = 2.0;
  IconData _selectedIcon;
  double rateAvg;
  int ratingCount;

  @override
  void initState() {
    super.initState();
    getRatingCount();
  }

  void IncreaseratingCount() {
    FirebaseFirestore.instance
        .collection("rating")
        .doc('ratingCounts')
        .update({"lastRateCount": FieldValue.increment(1)})
        .then((value) => print("Order Number Increased"))
        .catchError((error) => print("Failed: $error"));
  }

  void getRatingCount() async {
    FirebaseFirestore.instance
        .collection('rating')
        .doc('ratingCounts')
        .get()
        .then((DocumentSnapshot rate) {
      if (rate.exists) {
        setState(() {
          ratingCount = rate['lastRateCount'];
        });

        print('Rating Count: $ratingCount');
      }
    });
  }

  void updateRate() async {
    FirebaseFirestore.instance
        .collection("items")
        .doc(docName)
        .update({
          "rating": rateAvg,
        })
        .then((value) => print("Records Added Successfully!"))
        .catchError((error) => print("Failed: $error"));
    IncreaseratingCount();
    getRatingCount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: _ratingBar(_ratingBarMode),
        ),
        Text(
          'Rating: $_rating',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('items')
                  .doc(docName)
                  .get()
                  .then((DocumentSnapshot rate) {
                if (rate.exists) {
                  double currRate = rate['rating'].toDouble();
                  print('current rate of this item: $currRate');
                  print('ratinggggg count $ratingCount');
                  setState(() {
                    currRate =
                        currRate + _rating / (ratingCount.toDouble() + 1.00);
                    rateAvg = currRate;
                  });

                  print('Average rate: $currRate');
                }
                Get.snackbar("Rated!", ".",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 1));
                updateRate();
              });
            },
            color: Sushi,
            textColor: Colors.white,
            elevation: 0.2,
            child: Text("Rate")),
      ],
    );
  }

  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 30.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) async {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar.builder(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }
}
