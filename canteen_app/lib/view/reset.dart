import 'package:flutter/material.dart';
import '../model/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  static String id = 'reset';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool status = true;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _userEmailController = new TextEditingController();
  @override
  Future<void> resetPassword(String email) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const Text('Reset Your Password',
                  style: TextStyle(fontFamily: 'Trueno', fontSize: 40.0)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 70, left: 30, right: 70),
              child: TextFormField(
                controller: _userEmailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (value!.isEmpty || !regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        resetPassword(_userEmailController.text);
                        print('validate');
                      } else {
                        return null;
                      }

                      //
                    },
                    child: status == true
                        ? const Text(
                            "Reset",
                          )
                        : const CircularProgressIndicator(
                            backgroundColor: Colors.black38,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
