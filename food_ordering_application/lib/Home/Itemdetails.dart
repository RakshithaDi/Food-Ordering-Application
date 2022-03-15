import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/cartpage.dart';
import 'package:food_ordering_application/Home/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../cart.dart';
import '../constant.dart';
import '../item.dart';

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

  _ItemDetailsState(this.productId);
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cart'),
          backgroundColor: kredbackgroundcolor,
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
          child: Column(
            children: [
              Container(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('items')
                      .where('id', isEqualTo: productId)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        price = double.parse(data['price']);
                        name = data['name'];
                        imgUrl = data['imgUrl'];

                        final List<Item> items = [
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
                                    width: double.infinity,
                                    height: 300.0,
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Image.network(data['imgUrl']),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              ListTile(
                                title: Text(data['name']),
                                subtitle: Text(data['description']),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 18),
                                alignment: Alignment.topLeft,
                                child: Text('Rs.${data['price']}'),
                              ),
                              Ratings(),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: MaterialButton(
                                                onPressed: () {
                                                  cart.add(items[0]);
                                                },
                                                color: Colors.red,
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
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20, right: 5),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.yellow),
                                            child: Text(
                                              Cart.count.toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Rate For Food'),
        _ratingBar(_ratingBarMode),
        SizedBox(height: 20.0),
        Text(
          'Rating: $_rating',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
          onRatingUpdate: (rating) {
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
