import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart.dart';
import '../constant.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double quantityPrice;

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Check Out'),
          backgroundColor: kredbackgroundcolor,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Total(${Cart.basketItems.length.toString()}) Items",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                margin: EdgeInsets.only(left: 12, top: 10, bottom: 5),
              ),
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: 550,
                    child: ListView(
                      children: [
                        Builder(
                          builder: (context) {
                            return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: Cart.basketItems.length,
                              itemBuilder: (context, index) {
                                quantityPrice =
                                    Cart.basketItems[index].quantity *
                                        Cart.basketItems[index].price;
                                print(index);
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Text(
                                                Cart.basketItems[index].name,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      " Price: ",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      '${Cart.basketItems[index].quantity.toString()} * ${Cart.basketItems[index].price}',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                '= Rs.$quantityPrice ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 6),
                                          // Text(
                                          //   "M",
                                          //   style: TextStyle(
                                          //       color: Colors.grey, fontSize: 14),
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: <Widget>[
                                          //     Text(
                                          //       'Rs.${Cart.basketItems[index].price.toString()}',
                                          //       style: TextStyle(color: Colors.black),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                      Text(
                                        'Quantity:  ${Cart.basketItems[index].quantity} ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            "Total",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Text(
                            "Rs.${Cart.totalPrice.toString()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) => CheckOut()));
                      },
                      color: kredbackgroundcolor,
                      padding: EdgeInsets.only(
                          top: 12, left: 60, right: 60, bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: Text(
                        "Pay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                margin: EdgeInsets.only(top: 16),
              ),
            ],
          ),
        ),
      );
    });
  }
}
