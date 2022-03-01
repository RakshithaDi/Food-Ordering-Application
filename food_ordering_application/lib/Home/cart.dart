import 'package:flutter/material.dart';

import '../constant.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'),
        backgroundColor: kredbackgroundcolor,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          createSubTitle(),
          Expanded(
            child: Builder(
              builder: (context) {
                return ListView(
                  children: <Widget>[
                    createCartList(),
                  ],
                );
              },
            ),
          ),
          footer(context)
        ],
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
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
                  "Rs.299.00",
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
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) => CheckOutPage()));
            },
            color: kredbackgroundcolor,
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            child: Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total(3) Items",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 10, bottom: 5),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem();
      },
      itemCount: 5,
    );
  }

  createCartListItem() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.grey,
                    image: DecorationImage(
                        image: AssetImage("images/food11.jpg"))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          "Chicken Rice & Curry",
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "M",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Rs. 160",
                              style: TextStyle(color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                    padding: const EdgeInsets.only(
                                        bottom: 5, right: 10, left: 10),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: InkWell(
                                      child: Icon(
                                        Icons.add,
                                        size: 24,
                                        color: Colors.blueGrey,
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10, top: 8),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.red),
          ),
        )
      ],
    );
  }
}
