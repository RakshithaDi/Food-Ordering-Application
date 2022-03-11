import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class PersonalInfo extends StatefulWidget {
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
  bool edit = true;

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

    var outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(color: Colors.black),
    );

    var underlineBorder = UnderlineInputBorder(
        // borderSide: BorderSide(color: Colors.blue),
        );
    return Scaffold(
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
                        child: edit == false
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
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: edit,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: edit == true
                                    ? underlineBorder
                                    : outlineBorder,
                                labelText: 'First Name',
                                suffixIcon: edit == true
                                    ? Icon(Icons.format_list_bulleted)
                                    : Icon(Icons.drive_file_rename_outline),
                              ),
                              controller: firstNameController,
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: edit,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: edit == true
                                    ? underlineBorder
                                    : outlineBorder,
                                labelText: 'Last Name',
                                suffixIcon: edit == true
                                    ? Icon(Icons.format_list_bulleted)
                                    : Icon(Icons.drive_file_rename_outline),
                              ),
                              controller: secondNameController,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 100,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      readOnly: edit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder:
                            edit == true ? underlineBorder : outlineBorder,
                        labelText: 'Email',
                        suffixIcon: edit == true
                            ? Icon(Icons.format_list_bulleted)
                            : Icon(Icons.drive_file_rename_outline),
                      ),
                      controller: emailController,
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 100,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder:
                            edit == true ? underlineBorder : outlineBorder,
                        labelText: 'Phone No',
                        suffixIcon: edit == true
                            ? Icon(Icons.format_list_bulleted)
                            : Icon(Icons.drive_file_rename_outline),
                      ),
                      controller: phoneNoController,
                    )),
                edit == true
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kredbackgroundcolor,
                            ),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {}
                              setState(() {
                                edit = false;
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
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {}
                              setState(() {
                                edit = false;
                              });
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
        ));
  }
}
