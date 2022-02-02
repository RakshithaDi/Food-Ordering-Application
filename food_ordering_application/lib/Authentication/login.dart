import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  //const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 5,
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
              ),
              Text(
                'Welcome to FoodX!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Lets help you meet up your tasks.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
                width: 350,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        style: TextStyle(height: 1),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.remove_red_eye),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color(0XFFD8352C),
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
