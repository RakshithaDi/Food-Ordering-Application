import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ordering_application/Authentication/otp_setup.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  static String id = "signup_screen";
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();
  final TextEditingController _confirmPassworController =
      TextEditingController();
  String icon = '';

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    Center(
                      child: FoodLogo(),
                    ),
                    SignupTitle(),
                  ],
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 50,
                                  child: TextFormField(
                                    controller: _fnameController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'First Name',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      // suffixIcon: Icon(
                                      //   Icons.error,
                                      // ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the First Name';
                                        icon = 'error';
                                      } else if (RegExp(
                                              r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                          .hasMatch(value)) {
                                        return 'Enter a Valid Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 50,
                                  child: TextFormField(
                                    controller: _lnameController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      // suffixIcon: Icon(
                                      //   Icons.error,
                                      // ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the second Name';
                                      } else if (RegExp(
                                              r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                          .hasMatch(value)) {
                                        return 'Enter a Valid Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    controller: _userEmailController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      // suffixIcon: Icon(
                                      //   Icons.error,
                                      // ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    textCapitalization: TextCapitalization.none,
                                    enableSuggestions: false,
                                    validator: (value) {
                                      if (value.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _mobileNoController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Mobile No',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      // suffixIcon: Icon(
                                      //   Icons.error,
                                      // ),
                                    ),
                                    validator: (value) {
                                      String pattern =
                                          r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                      RegExp regExp = new RegExp(pattern);
                                      if (value.isEmpty) {
                                        return 'Please enter your mobile number';
                                      } else if (!regExp.hasMatch(value)) {
                                        return 'Please enter valid mobile number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    controller: _userPassworController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      // suffixIcon: Icon(
                                      //   Icons.error,
                                      // ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 7) {
                                        return 'Please enter a long password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    controller: _confirmPassworController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Re-type Password',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      // suffixIcon: Icon(
                                      //   Icons.error,
                                      // ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 7) {
                                        return 'Please enter a long password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 50, left: 50, top: 20),
                      child: SizedBox(
                        width: 250,
                        height: 45,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color(0XFFD8352C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              return 1;
                            } else {
                              return null;
                            }
                            //  Navigator.pushNamed(context, OtpSetup.id);
                          },
                          child: Text('Sign Up'),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            Text('Already Have an account?'),
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
                                  Navigator.pushNamed(context, Login.id);
                                },
                                child: Text('Sign In'),
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

class SingleRawTextField extends StatelessWidget {
  String word;
  SingleRawTextField({this.word});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Container(
                  height: 40,
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      // prefixIcon: Icon(Icons.email),
                      labelText: word,
                      labelStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Let\'s Get Started',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Create and account to continue!',
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
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
    );
  }
}

class FoodLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 25,
        bottom: 25,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: AssetImage('images/foodx.png'),
          height: 100.0,
          width: 200.0,
        ),
      ),
    );
  }
}
