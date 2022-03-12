import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/otp_setup.dart';
import 'package:food_ordering_application/Authentication/signup.dart';
import 'package:food_ordering_application/Home/home.dart';
import 'package:food_ordering_application/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'otp_verify.dart';

class Login extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String Useremail;
  String _password;
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();

  // Toggles the password show status
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool status = true;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setState(() {
        status = false;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userEmailController.text,
              password: _userPassworController.text);

      Useremail = _userPassworController.text;

      print('Sign in Succefully {$Useremail}');
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          status = true;
        });
        print('No user found for that email.');
        showAlertDialog('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        setState(() {
          status = true;
        });
        print('Wrong password provided for that user.');
        showAlertDialog('Wrong password provided for that user.', context);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool value = false;
  final maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFEf44949),
            Color(0xFFEf00e0e),
            Color(0xFFEEc00b0b),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Welcome to FoodX!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image(
                      image: AssetImage('images/foodxgg.png'),
                      height: 100.0,
                      width: 200.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Let\'s help you meet up your tasks.',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[100],
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
                  color: Colors.grey[300],
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
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: TextFormField(
                                controller: _userEmailController,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                decoration: InputDecoration(
                                  filled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: Colors.white.withOpacity(0.4),
                                  labelText: 'Email',
                                  errorStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.9)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value.isEmpty || !value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: _userPassworController,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                decoration: InputDecoration(
                                  filled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: Colors.white.withOpacity(0.4),
                                  labelText: 'Password',
                                  errorStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.9)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _toggle,
                                    icon: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 7) {
                                    return 'Please enter a long password';
                                  }
                                  return null;
                                },
                                onSaved: (val) => _password = val,
                                obscureText: _obscureText,
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
                                color: Colors.white,
                                fontSize: 14,
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
                          child: ElevatedButton(
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                                backgroundColor: Colors.white.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    side: BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _signInWithEmailAndPassword();
                                } else {
                                  return null;
                                }

                                //
                              },
                              child: status == true
                                  ? Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: Colors.black38,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))),
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
                      margin: EdgeInsets.only(right: 50, left: 50, top: 40),
                      child: TextButton(
                        child: Image(
                          image: AssetImage('images/googleIcon.png'),
                          width: 300,
                          height: 50,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 50, left: 50),
                    //   child: TextButton(
                    //     child: Image(
                    //       image: AssetImage('images/facebookIcon.png'),
                    //       width: 300,
                    //       height: 50,
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont Have an account?',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        OtpSetup(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
