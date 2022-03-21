import 'package:canteen_app/view/neworders.dart';
import 'package:canteen_app/view/pendingorders.dart';
import 'package:flutter/material.dart';

import 'completeorders.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          automaticallyImplyLeading: false,
          //title: const Text('Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(
                //icon: Icon(Icons.directions_car),
                text: 'New Orders',
              ),
              Tab(
                // icon: Icon(Icons.directions_transit),
                text: 'Pending Orders',
              ),
              Tab(
                // icon: Icon(Icons.directions_bike),
                text: 'Completed Orders',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewOrders(),
            PendingOrders(),
            CompleteOrders(),
          ],
        ),
      ),
    );
  }
}
