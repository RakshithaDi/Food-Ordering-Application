import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'notifications.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return IconButton(
        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        icon: FaIcon(FontAwesomeIcons.gamepad),
        onPressed: () {
          print("Pressed");
        });
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = 160.0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
        print(currentPageValue.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          elevation: 0,
          backgroundColor: kredbackgroundcolor,
          title: Text('Hello, Rakshitha!'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NotificationPage(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 5),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
                child: Text(
                  '5',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 34,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        backgroundColor: kbackgroundcolor,
        body: ListView(
          children: [
            Container(
              color: kredbackgroundcolor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        //  margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Let\'s select the best taste for you',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Vote for tomorrow',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Stack(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.double_arrow,
                                  color: Colors.white,
                                  size: 34,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: 3,
                        itemBuilder: (context, position) {
                          return buildPageItem(position);
                        }),
                  ),
                ),
                new DotsIndicator(
                  decorator: DotsDecorator(
                    activeColor: kredbackgroundcolor,
                  ),
                  dotsCount: 3,
                  position: currentPageValue,
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    children: [
                      Container(
                        child: Card(
                          elevation: 5,
                          child: new InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  width: 100,
                                  height: 80,
                                  child: Image.asset(
                                    'images/ricencurry1.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Rice & Curry',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          elevation: 5,
                          child: new InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  width: 100,
                                  height: 80,
                                  child: Image.asset(
                                    'images/burger1.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Burgers',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          elevation: 5,
                          child: new InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  width: 100,
                                  height: 80,
                                  child: Image.asset(
                                    'images/drink1.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Drinks',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          elevation: 5,
                          child: new InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, right: 5, left: 5),
                                  width: 100,
                                  height: 80,
                                  child: Image.asset(
                                    'images/drink1.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Drinks',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                'Rcommended',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Card(
                      elevation: 5,
                      child: new InkWell(
                        onTap: () {
                          print("tapped");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(top: 5, right: 5, left: 5),
                              height: 160,
                              width: double.infinity,
                              child: Image.asset(
                                'images/food11.jpg',
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const ListTile(
                              // leading: Icon(
                              //   Icons.star,
                              //   color: Colors.yellow,
                              // ),
                              title: Text(
                                'Chicken Rice & Curry',
                              ),

                              subtitle: Text(
                                'Rs 160',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Card(
                      elevation: 5,
                      child: new InkWell(
                        onTap: () {
                          print("tapped");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(top: 5, right: 5, left: 5),
                              height: 160,
                              width: double.infinity,
                              child: Image.asset(
                                'images/food11.jpg',
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const ListTile(
                              // leading: Icon(
                              //   Icons.star,
                              //   color: Colors.yellow,
                              // ),
                              title: Text(
                                'Chicken Rice & Curry',
                              ),

                              subtitle: Text(
                                'Rs 160',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //advertisment sliding animation
  Widget buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currtrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currtrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currtrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 160,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/ad.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
