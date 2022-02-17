import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constant.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                height: 190,
                color: kredbackgroundcolor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 60.0,
                            //color: Colors.grey,
                            margin: EdgeInsets.only(top: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                'Hello, Rakshithaaaa!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // color: Colors.blue,
                            margin: EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: AssetImage('images/menulogo.png'),
                                height: 50.0,
                                width: 200.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'Let\'s select the best taste for you',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 200,
                child: PageView.builder(
                    itemCount: 3,
                    itemBuilder: (context, position) {
                      return Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage('images/ad.jpg'),
                          ),
                        ),
                        child: Column(
                          children: [],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
