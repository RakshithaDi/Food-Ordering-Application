import 'package:flutter/material.dart';
import 'package:food_ordering_application/view/home.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:food_ordering_application/model/constant.dart';

class OtpVerify extends StatefulWidget {
  static String id = 'otp_verify';
  final int mobileno;
  OtpVerify(this.mobileno);

  @override
  _OtpVerifyState createState() => _OtpVerifyState(this.mobileno);
}

class _OtpVerifyState extends State<OtpVerify> {
  int mobileno;
  _OtpVerifyState(this.mobileno);
  @override
  Widget build(BuildContext context) {
    var text = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Enter the '),
          new TextSpan(
              text: 'OTP ', style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: 'sent to '),
          new TextSpan(
              text: '+94-{$mobileno}',
              style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kbackgroundcolor,
          elevation: 0.0,
          titleSpacing: 10.0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
        ),
        backgroundColor: kbackgroundcolor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
                width: double.infinity,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 45,
                      child: OtpTextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                        ),
                        numberOfFields: 5,
                        borderColor: Colors.black,
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Verification Code"),
                                  content:
                                      Text('Code entered is $verificationCode'),
                                );
                              });
                        }, // end onSubmit
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Don\'t receive the OTP? '),
                          TextSpan(
                              text: 'RESEND OTP ',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('images/otpVerify.png'),
                      height: 300.0,
                      width: 300.0,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color(0XFFD8352C),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.red)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Home.id);
                        },
                        child: Text('Verify & Proceed'),
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
