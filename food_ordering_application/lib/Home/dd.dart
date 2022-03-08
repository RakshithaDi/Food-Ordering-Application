import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../cart.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  int count = 0;
  void AddEachItems() async {
    for (int index = 0; index <= 3; index++) {
      // String addName = Cart.basketItems[index].name;
      // double addPrice = Cart.basketItems[index].price;
      // int addQuantity = Cart.basketItems[index].quantity;
      //
      // print(addName);
      // print(addPrice);
      // print(addQuantity);
      FirebaseFirestore.instance
          .collection("orders")
          .doc('fm')
          .collection('OrderItems')
          .doc('burger')
          .set({
            "name": 'addName',
            "price": 'addPrice',
            "quantity": 'addQuantity',
          })
          .then((value) => print("Each item added!"))
          .catchError((error) => print("Failed: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    AddEachItems();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Tutorial - googleflutter.com'),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () => {AddEachItems()},
          child: new Text('Button Clicks - ${count}'),
        ),
      ),
    );
  }
}
