import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/signup.dart';
import 'package:food_ordering_application/Home/home.dart';
import 'package:food_ordering_application/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userEmailController.text,
              password: _userPassworController.text);
      print(_userPassworController);
      print(_userEmailController);

      print('fsfsfsfsfsfs ${userCredential}');
      Navigator.pushNamed(context, Home.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showAlertDialog('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showAlertDialog('Wrong password provided for that user.', context);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool value = false;
  final maxLines = 5;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print('succesfully connected');
              return SafeArea(
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
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
                                  height: 30.0,
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
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.email,
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
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
                                  SizedBox(height: 20.0),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.remove_red_eye,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 7) {
                                          return 'Please enter a long password';
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        side: BorderSide(color: Colors.red)),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _signInWithEmailAndPassword();
                                    } else {
                                      return null;
                                    }

                                    //
                                  },
                                  child: Text(
                                    "Login",
                                  ),
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
                                      child: Text(
                                        "Sign Up",
                                      ),
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
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

showAlertDialog(String message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert Box"),
    content: Text(message),
    actions: [
      okButton,
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
