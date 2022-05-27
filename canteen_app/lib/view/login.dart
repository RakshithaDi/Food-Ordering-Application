import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:canteen_app/global.dart' as global;
import '../constant.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  late String Useremail;
  late String _password;
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();

  // Toggles the password show status
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

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage('Admin')),
          (route) => false);
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

  void CheckLoginCredential(String userName, String password) {
    FirebaseFirestore.instance
        .collection('staff')
        .doc(userName)
        .get()
        .then((DocumentSnapshot staff) {
      if (staff.exists) {
        if (password == staff['password']) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage('Staff')),
              (route) => false);
          print('login successful');
          print('$userName is sign in');
        } else {
          setState(() {
            status = true;
          });
          print('Wrong password provided for that user.');
          showAlertDialog('Wrong password provided for that user.', context);
        }
      } else {
        setState(() {
          status = true;
        });
        print('No user found for that email.');
        showAlertDialog('No user found for that username.', context);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool value = false;
  final maxLines = 5;
  String _selectedUserType = 'Staff';
  String loginTitle = 'Staff Login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Card(
                elevation: 6,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            color: lightGreen,
                            child: Center(
                              child: Text(
                                'Canteen Management System',
                                style: nameTitle,
                              ),
                            ),
                          ),
                          Image(
                            color: klblack,
                            image: AssetImage('images/newLogofoodx.png'),
                            height: 150.0,
                            width: 300.0,
                          ),
                        ],
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                loginTitle,
                                style: loginTitleStyle,
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: ListTile(
                                        leading: Radio<String>(
                                          value: 'Staff',
                                          groupValue: _selectedUserType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedUserType = value!;
                                              loginTitle = '$value Login';
                                            });
                                          },
                                        ),
                                        title: Text(
                                          'Staff',
                                          style: fstlyepromptTextFields,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListTile(
                                        leading: Radio<String>(
                                          value: 'Admin',
                                          groupValue: _selectedUserType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedUserType = value!;
                                              loginTitle = '$value Login';
                                            });
                                          },
                                        ),
                                        title: Text(
                                          'Admin',
                                          style: fstlyepromptTextFields,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      _selectedUserType == 'Staff'
                          ? Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: TextFormField(
                                              controller: _userEmailController,
                                              cursorColor: Colors.green,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                  color: titleColor,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey
                                                    .withOpacity(0.3),
                                                labelText: 'Username',
                                                labelStyle:
                                                    fstlyepromptTextFields,
                                                suffixIcon: const Icon(
                                                  Icons.email,
                                                  color: klblack,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              autocorrect: false,
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              enableSuggestions: false,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter your username';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: TextFormField(
                                              controller:
                                                  _userPassworController,
                                              cursorColor: Colors.green,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                  color: titleColor,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey
                                                    .withOpacity(0.3),
                                                labelText: 'Password',
                                                labelStyle:
                                                    fstlyepromptTextFields,
                                                suffixIcon: IconButton(
                                                  onPressed: _toggle,
                                                  icon: const Icon(
                                                    Icons
                                                        .remove_red_eye_rounded,
                                                    color: klblack,
                                                  ),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value.length < 4) {
                                                  return 'Please enter your password';
                                                }
                                                return null;
                                              },
                                              onSaved: (val) =>
                                                  _password = val!,
                                              obscureText: _obscureText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 50, left: 50, top: 40),
                                      child: SizedBox(
                                        width: 250,
                                        height: 50,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: lightGreen,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                CheckLoginCredential(
                                                    _userEmailController.text,
                                                    _userPassworController
                                                        .text);
                                              } else {
                                                return null;
                                              }

                                              //
                                            },
                                            child: status == true
                                                ? Text(
                                                    "Login",
                                                    style: buttonText,
                                                  )
                                                : const CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.black38,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: TextFormField(
                                              controller: _userEmailController,
                                              cursorColor: Colors.green,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                  color: titleColor,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey
                                                    .withOpacity(0.3),
                                                labelText: 'Email',
                                                labelStyle:
                                                    fstlyepromptTextFields,
                                                suffixIcon: const Icon(
                                                  Icons.email,
                                                  color: klblack,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              autocorrect: false,
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              enableSuggestions: false,
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    !value.contains('@')) {
                                                  return 'Please enter a valid email address';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: TextFormField(
                                              controller:
                                                  _userPassworController,
                                              cursorColor: Colors.green,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                  color: titleColor,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey
                                                    .withOpacity(0.3),
                                                labelText: 'Password',
                                                labelStyle:
                                                    fstlyepromptTextFields,
                                                suffixIcon: IconButton(
                                                  onPressed: _toggle,
                                                  icon: const Icon(
                                                    Icons
                                                        .remove_red_eye_rounded,
                                                    color: klblack,
                                                  ),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value.length < 7) {
                                                  return 'Please enter a long password';
                                                }
                                                return null;
                                              },
                                              onSaved: (val) =>
                                                  _password = val!,
                                              obscureText: _obscureText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 50, left: 50, top: 40),
                                      child: SizedBox(
                                        width: 250,
                                        height: 50,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: lightGreen,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _signInWithEmailAndPassword();
                                              } else {
                                                return null;
                                              }

                                              //
                                            },
                                            child: status == true
                                                ? Text(
                                                    "Login",
                                                    style: buttonText,
                                                  )
                                                : const CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.black38,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
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
