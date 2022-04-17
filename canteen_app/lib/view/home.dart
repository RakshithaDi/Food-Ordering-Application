import 'package:canteen_app/constant.dart';
import 'package:canteen_app/model/auth.dart';
import 'package:canteen_app/view/complaints.dart';
import 'package:canteen_app/view/products.dart';
import 'package:canteen_app/view/createaccounts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'category.dart';
import 'login.dart';
import 'neworders.dart';
import 'orders.dart';

class MyHomePage extends StatefulWidget {
  static String id = 'home';
  @override
  _MyHomePageState createState() => _MyHomePageState();

  String userType = '';
  MyHomePage(this.userType);
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canteen Management System'),
        centerTitle: true,
        backgroundColor: lightGreen,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.green[100],
              selectedColor: lightGreen,
              selectedTitleTextStyle: TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // backgroundColor: Colors.amber
              // openSideMenuWidth: 200
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                ),
                Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Admin',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Users',
                onTap: () {
                  page.jumpToPage(0);
                  CreateAccounts();
                },
                icon: Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Categories',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icon(Icons.food_bank_rounded),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Products',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icon(Icons.no_food),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Orders',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icon(Icons.event_note_sharp),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Complaints',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: Icon(Icons.report),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Sign Out',
                onTap: () async {
                  page.jumpToPage(5);
                  showAlertDialog(context);
                },
                icon: Icon(Icons.exit_to_app),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Dashboard',
                onTap: () {
                  page.jumpToPage(6);
                },
                icon: Icon(Icons.home),
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                CreateAccounts(),
                CategoryDetails(),
                Products(),
                OrdersView(),
                Complaints(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "YES",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        logout();
        // Navigator.of(context, rootNavigator: true).pop();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoadingScreen()));
        Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "NO",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
