import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import '../cart.dart';
import '../constant.dart';
import '../item.dart';
import 'Itemdetails.dart';
import 'itemspage.dart';
import 'messages.dart';
import 'notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_application/global.dart' as global;
import 'package:carousel_slider/carousel_slider.dart';

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
  int quantity = 1;
  String name;
  String imgUrl;
  double price;
  int notifyCount = 0;

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
      global.email = currentUser.email;
      print(global.email);
    }
    getNotificationCount();
    getAdsLinks();

    getAllItems();
    items.removeRange(0, items.length);
  }

  final List<String> imgList = [];
  void getAdsLinks() async {
    await FirebaseFirestore.instance
        .collection('advertisments')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        imgList.add(doc["imgUrl"]);
      });
    });
    setState(() {
      addAdsToSlider();
    });
  }

  void getNotificationCount() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: currentUser.email)
        .where('Status', isEqualTo: 'Pending')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.size == 0) {
        setState(() {
          Cart.NotificationLength(0);
        });
      } else {
        setState(() {
          Cart.NotificationLength(documentSnapshot.size);
        });
      }
    });
  }

  List<Item> items = [];
  void getAllItems() {
    FirebaseFirestore.instance
        .collection('items')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["id"]);
        items.add(Item(
            productId: doc["id"],
            name: doc["name"],
            price: double.parse(doc["price"]),
            imgUrl: doc["imgUrl"],
            quantity: 1));
      });
      //  print(items[9].name);
    });
  }

  final CarouselController _controller = CarouselController();
  int _current = 0;
  List<Widget> imageSliders = [];

  void addAdsToSlider() {
    imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());
    return Consumer<Cart>(builder: (context, cart, child) {
      // FirebaseFirestore.instance
      //     .collection('orders')
      //     .where('Email', isEqualTo: currentUser.email)
      //     .where('Status', isEqualTo: 'Pending')
      //     .get()
      //     .then((documentSnapshot) {
      //   if (documentSnapshot.size == 0) {
      //     cart.NotificationLength(0);
      //   } else {
      //     cart.NotificationLength(documentSnapshot.size);
      //   }
      // });

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          elevation: 0,
          backgroundColor: Sushi,
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
                  return currentUser.email != null
                      ? Text(
                          'Hello ${userprofile['fname']}!',
                          style: helloNname,
                        )
                      : Text('');
                }
                return Container(
                  child: CircularProgressIndicator(
                    color: titleColor,
                  ),
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
                  Cart.NotifyCount.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Messages(),
                  ),
                );
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.search,
            //     color: Colors.white,
            //     size: 34,
            //   ),
            //   onPressed: () {
            //     Navigator.push<void>(
            //       context,
            //       MaterialPageRoute<void>(
            //         builder: (BuildContext context) => SearchItemsPage(),
            //       ),
            //     );
            //   },
            // ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage<Item>(
                    onQueryUpdate: (s) => print(s),
                    barTheme: ThemeData(
                      appBarTheme: AppBarTheme(
                        color: Sushi,
                      ),
                    ),
                    items: items,
                    searchLabel: 'Search Food Items',
                    suggestion: Center(
                      child: Text('Filter Food items by name'),
                    ),
                    failure: Center(
                      child: Text('No Item Found!'),
                    ),
                    filter: (items) => [
                      items.name,
                    ],
                    builder: (items) => Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ItemDetails(items.productId),
                              ),
                            );
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 16),
                            decoration: BoxDecoration(
                                color: kbackgroundcolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 8, top: 8, bottom: 8),
                                  width: 100,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        items.imgUrl,
                                      ))),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 230,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 8, top: 4),
                                            child: Text(
                                              items.name,
                                              maxLines: 2,
                                              softWrap: true,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 230,
                                      child: Container(
                                        child: Text(
                                          "M",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 230,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                'Rs. ${items.price}',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Container(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white,
                                                    backgroundColor: Sushi,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    cart.add(items);
                                                  },
                                                  child: Text('Add to Cart'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: kbackgroundcolor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Container(
                color: Sushi,
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
                              bottom: 20,
                            ),
                            child: Text(
                              'Let\'s select the best taste for you',
                              style: bestTaste,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.only(top: 10),
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(
                    //           left: 10,
                    //         ),
                    //         child: Text(
                    //           'Vote for tomorrow',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.only(top: 10),
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 10),
                    //         child: Stack(
                    //           children: <Widget>[
                    //             IconButton(
                    //               icon: Icon(
                    //                 Icons.double_arrow,
                    //                 color: Colors.white,
                    //                 size: 34,
                    //               ),
                    //               onPressed: () {},
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height / 5.9,
                    width: MediaQuery.of(context).size.width / 0.8,
                    child: CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : titleColor)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  'Categories',
                  style: menutitles,
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
                      height: MediaQuery.of(context).size.height / 6.3, //123,
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
                                        style: labeltext,
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
                      child: CircularProgressIndicator(
                        color: titleColor,
                      ),
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  'Rcommended',
                  style: menutitles,
                ),
              ),
              Container(
                height: 510, //MediaQuery.of(context).size.height / 2.8, //210
                child: FutureBuilder(
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
                      return GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(
                          snapshot.data.docs.length,
                          (index) {
                            QueryDocumentSnapshot recommend =
                                snapshot.data.docs[index];

                            price = double.parse(recommend['price']);
                            name = recommend['name'];
                            imgUrl = recommend['imgUrl'];

                            final List<Item> items = [
                              for (var i = 0;
                                  i < snapshot.data.docs.length;
                                  i++)
                                Item(
                                    name: name,
                                    price: price,
                                    imgUrl: imgUrl,
                                    quantity: quantity),
                            ];
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: 0,
                              ),
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ItemDetails(recommend['id']),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 5, right: 5, left: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: double.infinity,
                                              child: Image.network(
                                                recommend['imgUrl'],
                                                alignment: Alignment.topLeft,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7),
                                                child: Text(
                                                  recommend['name'],
                                                  style: labeltext,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0, left: 20),
                                                      child: Center(
                                                        child: Text(
                                                          'Rs. ${recommend['price']}',
                                                          style: labelprice,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.add_box,
                                                          color: titleColor,
                                                          size: 30,
                                                        ),
                                                        onPressed: () {
                                                          print('tapped');
                                                          cart.add(
                                                              items[index]);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                      );
                    }

                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: titleColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
