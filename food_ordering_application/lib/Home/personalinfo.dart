import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class PersonalInfo extends StatefulWidget {
  static String id = 'personalInfo';
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  String userEmail;
  String fname;
  String lname;
  String phoneno;
  bool edit = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
    getUserDetails();
  }

  void getUserDetails() async {
    FirebaseFirestore.instance
        .collection('userprofile')
        .doc(userEmail)
        .get()
        .then((DocumentSnapshot userData) {
      if (userData.exists) {
        setState(() {
          fname = userData['fname'];
          lname = userData['lname'];
          phoneno = userData['mobileno'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = userEmail;
    firstNameController.text = fname;
    secondNameController.text = lname;
    phoneNoController.text = phoneno;
    //var decorationOutline = OutlineInputBorder(borderRadius: BorderRadius.circular(0));

    // var outlineBorder = OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(0),
    //   borderSide: BorderSide(color: Colors.black),
    // );
    //
    // var underlineBorder = UnderlineInputBorder(
    //     // borderSide: BorderSide(color: Colors.blue),
    //     );
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Personal Information'),
        backgroundColor: kredbackgroundcolor,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Center(
                      child: edit == true
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'images/editprofile.png',
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 80,
                          child: Card(
                            elevation: 2,
                            color: Colors.red.withOpacity(0.6),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              textAlign: TextAlign.center,
                              enabled: edit,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'First Name',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: firstNameController,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 80,
                          child: Card(
                            elevation: 2,
                            color: Colors.red.withOpacity(0.6),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              textAlign: TextAlign.center,
                              enabled: edit,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Last Name',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                suffixIcon: edit == false
                                    ? Icon(
                                        Icons.format_list_bulleted,
                                        color: Colors.white,
                                      )
                                    : Icon(Icons.drive_file_rename_outline,
                                        color: Colors.white),
                              ),
                              controller: secondNameController,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: 80,
                  child: Card(
                    elevation: 2,
                    color: Colors.red.withOpacity(0.6),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                      // readOnly: true,
                      enabled: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                        suffixIcon: edit == false
                            ? Icon(
                                Icons.format_list_bulleted,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.drive_file_rename_outline,
                                color: Colors.white,
                              ),
                      ),
                      controller: emailController,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  height: 80,
                  child: Card(
                    elevation: 2,
                    color: Colors.red.withOpacity(0.6),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                      // readOnly: true,
                      enabled: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Phone No',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                        suffixIcon: edit == false
                            ? Icon(
                                Icons.format_list_bulleted,
                                color: Colors.white,
                              )
                            : Icon(Icons.drive_file_rename_outline,
                                color: Colors.white),
                      ),
                      controller: phoneNoController,
                    ),
                  )),
              edit == false
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kredbackgroundcolor,
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState.validate()) {}
                            setState(() {
                              edit = true;
                            });
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red.withOpacity(0.8),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState.validate()) {
                              showAlertDialog(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
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
        FirebaseFirestore.instance
            .collection("userprofile")
            .doc(userEmail)
            .update({
              "fname": firstNameController.text,
              "lname": secondNameController.text,
            })
            .then((value) => print("Records Updated Successfully!"))
            .catchError((error) => print("Failed: $error"));

        Navigator.pop(context);
        setState(() {
          Navigator.pushReplacementNamed(context, PersonalInfo.id);
          edit = false;
        });
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
      content: Text("Are your sure you want to change it?"),
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
}
