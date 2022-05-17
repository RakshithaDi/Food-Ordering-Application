import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'package:food_ordering_application/model/constant.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Sushi,
        title: Text(
          'Reset Password',
          style: appbarText,
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'We will send you an email to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      controller: _emailTextController,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: titleColor,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Email',
                        labelStyle: fstlyepromptTextFields,
                        suffixIcon: Icon(
                          Icons.email,
                          color: klblack,
                        ),
                        border: InputBorder.none,
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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Sushi,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: _emailTextController.text)
                            .then((value) {
                          Navigator.of(context).pop();
                          Get.snackbar(
                              "Check your emails to reset your password!", "",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 3));
                        });
                      } else {
                        return null;
                      }
                    },
                    child: Text('Reset Password'))
              ],
            ),
          ))),
    );
  }
}
