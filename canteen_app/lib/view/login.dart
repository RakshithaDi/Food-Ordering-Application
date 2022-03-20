import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'reset.dart';
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
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      Navigator.pushNamedAndRemoveUntil(
          context, MyHomePage.id, (route) => false);
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
  String _selectedUserType = 'Staff';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Canteen Management System',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Admin Login',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ListTile(
                        leading: Radio<String>(
                          value: 'Staff',
                          groupValue: _selectedUserType,
                          onChanged: (value) {
                            setState(() {
                              _selectedUserType = value!;
                            });
                          },
                        ),
                        title: const Text('Staff'),
                      ),
                      ListTile(
                        leading: Radio<String>(
                          value: 'Admin',
                          groupValue: _selectedUserType,
                          onChanged: (value) {
                            setState(() {
                              _selectedUserType = value!;
                            });
                          },
                        ),
                        title: const Text('Admin'),
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
                                        labelStyle: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.email,
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
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
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextFormField(
                                      controller: _userPassworController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Password',
                                        labelStyle: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: _toggle,
                                          icon: Icon(
                                              Icons.remove_red_eye_rounded),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 7) {
                                          return 'Please enter a long password';
                                        }
                                        return null;
                                      },
                                      onSaved: (val) => _password = val!,
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
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ResetPassword.id);
                                  },
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
                              margin:
                                  const EdgeInsets.only(right: 50, left: 50),
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
                                      if (_formKey.currentState!.validate()) {
                                        _signInWithEmailAndPassword();
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: status == true
                                        ? const Text(
                                            "Login",
                                          )
                                        : const CircularProgressIndicator(
                                            backgroundColor: Colors.black38,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
                                        labelStyle: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.email,
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
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
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextFormField(
                                      controller: _userPassworController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Password',
                                        labelStyle: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: _toggle,
                                          icon: Icon(
                                              Icons.remove_red_eye_rounded),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 7) {
                                          return 'Please enter a long password';
                                        }
                                        return null;
                                      },
                                      onSaved: (val) => _password = val!,
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
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 50, left: 50),
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
                                      if (_formKey.currentState!.validate()) {
                                        _signInWithEmailAndPassword();
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: status == true
                                        ? const Text(
                                            "Login",
                                          )
                                        : const CircularProgressIndicator(
                                            backgroundColor: Colors.black38,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
