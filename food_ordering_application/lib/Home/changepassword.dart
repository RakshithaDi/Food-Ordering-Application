import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ChangePassword extends StatefulWidget {
  static String id = 'changepassword';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool _obscureText = true;
  String _currentPassword;
  String _newPassword;
  bool status = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _changePassword(String currentPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user.email, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        setState(() {
          status = true;
        });
        print("Password Updated");
        ConfirmAlertDialog(
            context, 'You have successfully updated your password');
      }).catchError((error) {
        setState(() {
          status = true;
        });
        print("Something wrong");
        ConfirmAlertDialog(context, 'Something wrong');
      });
    }).catchError((err) {
      print("Current password wrong");
      ConfirmAlertDialog(context, 'Current Password is wrong!');
      setState(() {
        status = true;
      });
    });
  }

  @override
  void dispose() {
    newPassword.dispose();
    currentPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change Password'),
        backgroundColor: Sushi,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: currentPassword,
                    cursorColor: greenTheme,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.9),
                      errorStyle: TextStyle(color: Colors.red),
                      labelText: 'Current Password',
                      labelStyle: TextStyle(fontSize: 15, color: titleColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: Icon(
                          Icons.remove_red_eye_rounded,
                          color: titleColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the current password';
                      } else if (value.length < 7) {
                        return 'should be at least 8 characters long';
                      }
                      return null;
                    },
                    onSaved: (val) => _currentPassword = val,
                    obscureText: _obscureText,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: newPassword,
                    cursorColor: greenTheme,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.9),
                      errorStyle: TextStyle(color: Colors.red),
                      labelText: 'Enter New Password',
                      labelStyle: TextStyle(fontSize: 15, color: titleColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: Icon(
                          Icons.remove_red_eye_rounded,
                          color: titleColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a new password';
                      } else if (value.length < 7) {
                        return 'should be at least 8 characters long';
                      }
                      return null;
                    },
                    onSaved: (val) => _newPassword = val,
                    obscureText: _obscureText,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Sushi,
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        showAlertDialog(
                            context, 'Are you sure you want to change it?');
                      }
                    },
                    child: status == true
                        ? Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          )
                        : CircularProgressIndicator(
                            backgroundColor: Colors.black38,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, message) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        setState(() {
          status = false;
        });
        _changePassword(currentPassword.text, newPassword.text);
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      // title: Text("Confirm"),
      content: Text('$message'),
      actions: [
        continueButton,
        cancelButton,
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

  ConfirmAlertDialog(BuildContext context, message) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text(
        "Ok",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        // setState(() {
        //   Navigator.pushReplacementNamed(context, ChangePassword.id);
        // });
      },
    );
    AlertDialog alert = AlertDialog(
      // title: Text("Confirm"),
      content: Text('$message'),
      actions: [
        continueButton,
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
}
