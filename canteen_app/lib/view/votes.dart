import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Votes extends StatefulWidget {
  const Votes({Key? key}) : super(key: key);

  @override
  _VotesState createState() => _VotesState();
}

class _VotesState extends State<Votes> {
  final form = GlobalKey<FormState>();
  bool addButton = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: form,
                        child: Column(
                          children: [
                            Container(
                              child: const Text(
                                'Add food item to vote',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: titleColor),
                              ),
                              margin: EdgeInsets.only(left: 10, bottom: 20),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: TextFormField(
                                // controller:
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                    color: titleColor,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.3),
                                  labelText: 'Name',
                                  labelStyle: fstlyepromptTextFields,
                                  border: InputBorder.none,
                                ),
                                autocorrect: false,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the food item name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(right: 50, left: 50),
                              child: SizedBox(
                                width: 100,
                                height: 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (form.currentState!.validate()) {
                                        setState(() {
                                          addButton = false;
                                        });
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: addButton == true
                                        ? const Text(
                                            "Add",
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
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: const Text(
                              'Users',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: titleColor),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("votes")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                //  return CircularProgressIndicator();
                              }

                              if (snapshot.hasData) {
                                return Container(
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        QueryDocumentSnapshot data =
                                            snapshot.data!.docs[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 50,
                                          child: Card(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  data['name'],
                                                  style: fstlyepromptTextFields,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, message) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      //title: Text("Log Out"),
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
}
