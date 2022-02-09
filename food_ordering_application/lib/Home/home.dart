import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/account.dart';
import 'package:food_ordering_application/Home/cart.dart';
import 'package:food_ordering_application/Home/menu.dart';

import '../constant.dart';

class Home extends StatefulWidget {
  static String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Menu(),
            Cart(),
            Account(),
          ],
          controller: controller,
        ),
        // Center(
        //   child: _widgetOptions.elementAt(_selectedIndex),
        // ),

        bottomNavigationBar: Material(
          color: kredbackgroundcolor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(Icons.shopping_cart_rounded),
              ),
              Tab(
                icon: Icon(Icons.account_circle_rounded),
              ),
            ],
            controller: controller,
          ),
        ),
      ),
    );
  }
}
