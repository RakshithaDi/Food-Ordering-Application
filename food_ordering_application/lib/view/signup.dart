import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ordering_application/model/constant.dart';

import 'home.dart';
import '../model/registeruser.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  static String id = "signup_screen";
  String phoneno;
  Signup(this.phoneno);
  @override
  _SignupState createState() => _SignupState(this.phoneno);
}

class _SignupState extends State<Signup> {
  String phoneno;
  _SignupState(this.phoneno);
  bool _obscureText = true;

  String _password;
  String _confirmPassword;
  String mobileno;
  bool states = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String UserEmail;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();
  final TextEditingController _confirmPassworController =
      TextEditingController();
  String checkpassworweak;
  String checkaccexist;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      setState(() {
        states = false;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _userEmailController.text,
              password: _confirmPassworController.text);
      UserEmail = _userEmailController.text;
      mobileno = _mobileNoController.text;
      RegisterUser adduser = RegisterUser(_fnameController.text,
          _lnameController.text, _userEmailController.text, mobileno);
      adduser.addUser();
      // Navigator.push<void>(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => Home(),
      //   ),
      // );

      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
      print('Registered succesfully {$UserEmail} ');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          states = true;
        });
        print('The password provided is too weak.');
        showAlertDialog('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          states = true;
        });
        print('The account already exists for that email.');
        showAlertDialog('The account already exists for that email.', context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _mobileNoController.text = phoneno;
    return Scaffold(
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
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  cursorColor: Colors.green,
                                  controller: _fnameController,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: titleColor,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'First Name',
                                    labelStyle: fstlyepromptTextFields,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter the First Name';
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
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: _lnameController,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: titleColor,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Last Name',
                                    labelStyle: fstlyepromptTextFields,
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
                                child: TextFormField(
                                  controller: _userEmailController,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: titleColor,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Email',
                                    labelStyle: fstlyepromptTextFields,
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: klblack,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Container(
                    //             child: TextFormField(
                    //               enabled: false,
                    //               readOnly: true,
                    //               maxLength: 10,
                    //               keyboardType: TextInputType.number,
                    //               inputFormatters: [
                    //                 FilteringTextInputFormatter.digitsOnly
                    //               ],
                    //               controller: _mobileNoController,
                    //               decoration: InputDecoration(
                    //                 filled: true,
                    //                 fillColor: Colors.white,
                    //                 labelText: 'Mobile No',
                    //                 labelStyle: TextStyle(
                    //                   fontSize: 15,
                    //                 ),
                    //                 border: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(11),
                    //                 ),
                    //                 // suffixIcon: Icon(
                    //                 //   Icons.error,
                    //                 // ),
                    //               ),
                    //               validator: (value) {
                    //                 String pattern =
                    //                     r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    //                 RegExp regExp = new RegExp(pattern);
                    //                 if (value.isEmpty) {
                    //                   return 'Please enter your mobile number';
                    //                 } else if (!regExp.hasMatch(value)) {
                    //                   return 'Please enter valid mobile number';
                    //                 }
                    //                 return null;
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _userPassworController,
                                      decoration: InputDecoration(
                                        helperText:
                                            '*Should be at least 8 characters long',
                                        helperStyle: TextStyle(
                                          color: titleColor,
                                        ),
                                        labelText: 'Password',
                                        errorStyle: TextStyle(
                                          color: titleColor,
                                        ),
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelStyle: fstlyepromptTextFields,
                                        suffixIcon: IconButton(
                                          onPressed: _toggle,
                                          icon: Icon(
                                            Icons.remove_red_eye_rounded,
                                            color: klblack,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a long password';
                                        } else if (value.length < 7) {
                                          return 'should be at least 8 characters long';
                                        }
                                        return null;
                                      },
                                      onSaved: (val) => _password = val,
                                      obscureText: _obscureText,
                                    ),
                                  ],
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
                                child: TextFormField(
                                  controller: _confirmPassworController,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: titleColor,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Re-Type Password',
                                    labelStyle: fstlyepromptTextFields,
                                    suffixIcon: IconButton(
                                      onPressed: _toggle,
                                      icon: Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: klblack,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a long password';
                                    } else if (value.length < 7) {
                                      return 'should be at least 8 characters long';
                                    } else if (_userPassworController.text !=
                                        _confirmPassworController.text) {
                                      return 'Password not matching';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => _confirmPassword = val,
                                  obscureText: _obscureText,
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
                    margin: EdgeInsets.only(
                      right: 50,
                      left: 50,
                    ),
                    child: SizedBox(
                      width: 250,
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Sushi,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            createUserWithEmailAndPassword();
                          } else {
                            return null;
                          }
                          //  Navigator.pushNamed(context, OtpSetup.id);
                        },
                        child: states == true
                            ? Text(
                                'Sign Up',
                                style: buttonText,
                              )
                            : CircularProgressIndicator(
                                backgroundColor: Colors.black38,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(titleColor)),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Row(
                        children: [
                          Text(
                            'Already Have an account?',
                            style: fstlyemontserratAlternatesText,
                          ),
                          SizedBox(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: titleColor,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, Login.id);
                              },
                              child: Text(
                                'Sign In',
                                style: normalText,
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
          Text('Let\'s Get Started', style: fstlyepoppinsTitle),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Create an account to continue!',
            style: fstlyepoppinsSubtitle,
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
            width: MediaQuery.of(context).size.width - 30,
            child: Divider(
              thickness: 2,
              color: klblack,
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
        top: 45,
        bottom: 25,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          color: Sushi,
          image: AssetImage('images/newLogofoodx.png'),
          height: 100.0,
          width: 300.0,
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
