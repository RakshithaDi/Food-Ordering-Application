import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUser {
  static String id = 'registeruser';
  final String fname;
  final String lname;
  final String email;
  final int mobileno;

  RegisterUser(this.fname, this.lname, this.email, this.mobileno);

  // Create a CollectionReference called users that references the firestore collection

  CollectionReference users =
      FirebaseFirestore.instance.collection('userprofile');

  Future<void> addUser() {
    return users
        .doc(email)
        .set({
          'name': '$fname $lname', // John Doe
          'email': email, // Stokes and Sons
          'mobileno': mobileno // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
