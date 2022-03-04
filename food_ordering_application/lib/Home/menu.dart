import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cart.dart';
import '../constant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'itemspage.dart';
import 'notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget {
  static String id = 'menu';
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = 160.0;
  int categoryId;

  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
        print(currentPageValue.toString());
      });
    });
    if (currentUser != null) {
      print(currentUser.email);
    }
    //  downloadURLExample();
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
          title: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("userprofile")
                  .doc('${currentUser.email}')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  // return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  Map<String, dynamic> userprofile =
                      snapshot.data.data() as Map<String, dynamic>;
                  return Text('Hello ${userprofile['fname']}!');
                }
                return Container(
                  child: CircularProgressIndicator(),
                );
              }),
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
                  Cart.count.toString(),
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
                  height: 150,
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
              margin: EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  //  return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  print('has data');
                  return Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,

                      // ignore: missing_return
                      itemBuilder: (BuildContext context, index) {
                        QueryDocumentSnapshot category =
                            snapshot.data.docs[index];
                        return Container(
                          child: Card(
                            elevation: 5,
                            child: new InkWell(
                              onTap: () {
                                categoryId = category['id'];
                                print(categoryId);
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        Items(categoryId),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 5, right: 5, left: 5),
                                    width: 100,
                                    height: 80,
                                    child: Image.network(
                                      category['imgUrl'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text(
                                      category['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: Text(
                'Rcommended',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('items')
                  .where('recommend', isEqualTo: 'yes')
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  //   return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  print('has data in items');
                  return Container(
                    height: 200,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        snapshot.data.docs.length,
                        (index) {
                          QueryDocumentSnapshot recommend =
                              snapshot.data.docs[index];
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 0,
                            ),
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
                                      margin: EdgeInsets.only(
                                          top: 5, right: 5, left: 5),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: double.infinity,
                                            child: Image.network(
                                              recommend['imgUrl'],
                                              alignment: Alignment.topLeft,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              recommend['name'],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              'Rs. ${recommend['price']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
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
