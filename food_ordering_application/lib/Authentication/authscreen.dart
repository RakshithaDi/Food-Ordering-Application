import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_application/Authentication/login.dart';

// class AuthScreen extends StatefulWidget {
//   static String id = 'authscreen';
//   const AuthScreen({Key key}) : super(key: key);
//
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final _auth = FirebaseAuth.instance;
//
//   var _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp().whenComplete(() {
//       print("completed");
//       setState(() {});
//     });
//   }
//
//   void _submitAuthForm(
//     String email,
//     String password,
//     String userName,
//     bool isLogin,
//     BuildContext ctx,
//   ) async {
//     // ignore: unused_local_variable
//     UserCredential userCredential;
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       if (isLogin) {
//         userCredential = await _auth.signInWithEmailAndPassword(
//             email: email, password: password);
//       } else {
//         userCredential = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);
//       }
//     } on PlatformException catch (err) {
//       var message = "An error occured please check your credentails";
//
//       if (err.message != null) {
//         message = err.message;
//       }
//
//       ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
//         content: Text(message),
//         backgroundColor: Theme.of(ctx).errorColor,
//       ));
//
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (err) {
//       // ignore: avoid_print
//       print(err);
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Login(_submitAuthForm, _isLoading),
//     );
//   }
// }
