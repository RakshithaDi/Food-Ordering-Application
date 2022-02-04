import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ordering_application/Authentication/otp_setup.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  static String id = "signup_screen";
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: ListView(
            children: [
              Center(
                child: FoodLogo(),
              ),
              SignupTitle(),
              Container(
                child: Row(
                  children: [
                    DoubleRawTextField('First Name'),
                    DoubleRawTextField('Last Name'),
                  ],
                ),
              ),
              SingleRawTextField(word: 'Email'),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, top: 10),
              //   child: Text(
              //     'Gender',
              //     style: TextStyle(
              //         fontSize: 13,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey[500]),
              //   ),
              // ),
              // Container(
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             height: 45,
              //             child: Card(
              //               elevation: 5,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               child: Center(
              //                 child: ListTile(
              //                   title: Padding(
              //                     padding: const EdgeInsets.only(bottom: 1),
              //                     child: Padding(
              //                       padding:
              //                           const EdgeInsets.only(bottom: 18.0),
              //                       child: Text(
              //                         "Male",
              //                         style: TextStyle(
              //                           fontSize: 13,
              //                           color: Colors.grey[700],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   leading: Padding(
              //                     padding: const EdgeInsets.only(bottom: 18),
              //                     child: Radio(
              //                       value: 1,
              //                       groupValue: val,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           val = value;
              //                           print(val);
              //                         });
              //                       },
              //                       activeColor: Colors.blue,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             height: 45,
              //             child: Card(
              //               elevation: 5,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               child: ListTile(
              //                 title: Padding(
              //                   padding: const EdgeInsets.only(bottom: 18.0),
              //                   child: Text(
              //                     "Female",
              //                     style: TextStyle(
              //                       fontSize: 13,
              //                       color: Colors.grey[700],
              //                     ),
              //                   ),
              //                 ),
              //                 leading: Padding(
              //                   padding: const EdgeInsets.only(bottom: 18.0),
              //                   child: Radio(
              //                     value: 2,
              //                     groupValue: val,
              //                     onChanged: (value) {
              //                       setState(() {
              //                         val = value;
              //                         print(val);
              //                       });
              //                     },
              //                     activeColor: Colors.blue,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SingleRawTextField(word: 'Mobile No'),
              SingleRawTextField(word: 'Password'),
              SingleRawTextField(word: 'Confirm Password'),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 50, left: 50),
                child: SizedBox(
                  width: 250,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0XFFD8352C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, OtpSetup.id);
                    },
                    child: Text('Sign Up'),
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      Text('Already Have an account?'),
                      SizedBox(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            //backgroundColor: Color(0XFFD8352C),
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Login.id);
                          },
                          child: Text('Sign In'),
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

class SingleRawTextField extends StatelessWidget {
  String word;
  SingleRawTextField({this.word});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Container(
                  height: 40,
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      // prefixIcon: Icon(Icons.email),
                      labelText: word,
                      labelStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoubleRawTextField extends StatelessWidget {
  String type;
  DoubleRawTextField(this.type);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          child: Container(
            height: 40,
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                // prefixIcon: Icon(Icons.email),

                labelText: type,
                labelStyle: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Let\'s Get Started',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Create and account to continue!',
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
            width: 350,
            child: Divider(
              thickness: 2,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 25,
        bottom: 25,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: AssetImage('images/foodx.png'),
          height: 100.0,
          width: 200.0,
        ),
      ),
    );
  }
}
