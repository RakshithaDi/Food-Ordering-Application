import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  //const login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: ListView(
            children: <Widget>[
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
                      'Welcome to FoodX!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Lets help you meet up your tasks.',
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
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              Container(
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
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 30),
                height: 40,
                child: SizedBox(
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
                    child: Text('Forgot Password?'),
                  ),
                ),
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
                    child: Text('Sign In'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: SizedBox(
                  height: 50,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                        //primary: Colors.white,
                        // backgroundColor: Color(0XFFD8352C),

                        side: BorderSide(color: Colors.black87, width: 1)),
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text(
                      'Sign In With Google',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: SizedBox(
                  height: 50,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                        //primary: Colors.white,
                        // backgroundColor: Color(0XFFD8352C),

                        side: BorderSide(color: Colors.black87, width: 1)),
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text(
                      'Sign In With Google',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      Text('Dont Have an account?'),
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
                          child: Text('Sign Up'),
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
