import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserCruds {
  late String username;
  late String password;

  UserCruds({required this.username, required this.password});

  CollectionReference users = FirebaseFirestore.instance.collection('staff');

  Future<void> addUser() {
    return users
        .doc(username)
        .set({
          'username': username,
          'password': password,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
