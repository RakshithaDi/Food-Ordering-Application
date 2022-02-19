import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ordering_application/Authentication/signup.dart';
import 'package:food_ordering_application/Home/home.dart';
import 'package:food_ordering_application/constant.dart';

import 'otp_setup.dart';

class Login extends StatefulWidget {
  //const login({Key? key}) : super(key: key);
  static String id = 'loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool value = false;
  final maxLines = 5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kredbackgroundcolor,
        //   elevation: 0.0,
        //   titleSpacing: 10.0,
        //   centerTitle: true,
        //   leading: InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.black54,
        //     ),
        //   ),
        // ),
        backgroundColor: kbackgroundcolor,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage('images/foodx.png'),
                            height: 100.0,
                            width: 200.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Welcome to FoodX!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Let\'s help you meet up your tasks.',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                            width: 350,
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: maxLines * 13.0,
                              child: TextFormField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              height: maxLines * 13.0,
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: Icon(Icons.remove_red_eye),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 30),
                        height: 40,
                        child: SizedBox(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 50, left: 50),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color(0XFFD8352C),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Colors.red)),
                            ),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {
                                Navigator.pushNamed(context, Home.id);
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child: Text('Sign In'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, left: 50),
                      child: TextButton(
                        child: Image(
                          image: AssetImage('images/googleIcon.png'),
                          width: 300,
                          height: 50,
                        ),
                        // style: TextButton.styleFrom(
                        //     side: BorderSide(color: Colors.grey, width: 0.1)),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, left: 50),
                      child: TextButton(
                        child: Image(
                          image: AssetImage('images/facebookIcon.png'),
                          width: 300,
                          height: 50,
                        ),
                        // style: TextButton.styleFrom(
                        //     side: BorderSide(color: Colors.grey[600], width: 1)),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            Text('Dont Have an account?'),
                            SizedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  //backgroundColor: Color(0XFFD8352C),
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, Signup.id);
                                },
                                child: Text('Sign Up'),
                              ),
                            ),
                          ],
                        ),
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
  }
}
