import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
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
                child: Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage('images/foodx.png'),
                      height: 100.0,
                      width: 200.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Let\'s Get Started',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Create and account to continue!',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // prefixIcon: Icon(Icons.email),
                              labelText: 'First Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            style: TextStyle(height: 1),
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //  prefixIcon: Icon(Icons.remove_red_eye),
                              labelText: 'Last Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Text(
                  'Gender',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF545454)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text("Male"),
                            leading: Radio(
                              value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                  print(val);
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text("Female"),
                            leading: Radio(
                              value: 2,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                  print(val);
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // prefixIcon: Icon(Icons.email),
                              labelText: 'Mobile No',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // prefixIcon: Icon(Icons.email),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // prefixIcon: Icon(Icons.email),
                              labelText: 'Confirm Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 50, left: 50),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0XFFD8352C),
                    ),
                    onPressed: () {},
                    child: Text('Sign Up'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
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
                          onPressed: () {},
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
