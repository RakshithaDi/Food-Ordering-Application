import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/pendingOrders.dart';

import '../constant.dart';
import 'completedorders.dart';

class OrdersHome extends StatefulWidget {
  static String id = 'orders';
  const OrdersHome({Key key}) : super(key: key);

  @override
  _OrdersHomeState createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Sushi,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.downloading_sharp),
                  text: 'Pending Orders',
                ),
                Tab(
                  icon: Icon(Icons.bookmark_border),
                  text: 'Completed Orders',
                ),
              ],
            ),
            centerTitle: true,
            title: const Text('Orders'),
          ),
          body: const TabBarView(
            children: [PendingOrders(), completedOrders()],
          ),
        ),
      ),
    );
  }
}
