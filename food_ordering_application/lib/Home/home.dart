import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/account.dart';
import 'package:food_ordering_application/Home/cart.dart';
import 'package:food_ordering_application/Home/complaint.dart';
import 'package:food_ordering_application/Home/menu.dart';
import 'package:food_ordering_application/Home/search.dart';

import '../constant.dart';

class Home extends StatefulWidget {
  static String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
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
            Complaints(),
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
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 40,
                child: Row(
                  children: [
                    Tab(
                      icon: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
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
                          '5',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.report,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ],
            controller: controller,
          ),
        ),
      ),
    );
  }
}
