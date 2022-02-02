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
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87,
                  ),
                  margin: const EdgeInsets.only(
                    top: 20.0,
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
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Welcome to FoodX!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Lets help you meet up your tasks.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                height: 20.0,
                width: 350,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
