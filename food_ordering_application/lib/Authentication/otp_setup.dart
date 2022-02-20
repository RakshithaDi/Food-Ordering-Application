import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering_application/Authentication/otp_verify.dart';
import 'package:food_ordering_application/constant.dart';
import 'package:food_ordering_application/registeruser.dart';

class OtpSetup extends StatefulWidget {
  static String id = 'otp_setup';
  final int mobileno;
  OtpSetup(this.mobileno);
  @override
  _OtpSetupState createState() => _OtpSetupState(this.mobileno);
}

class _OtpSetupState extends State<OtpSetup> {
  int mobileno;
  _OtpSetupState(this.mobileno);
  TextEditingController _mobilenoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _mobilenoController.text = mobileno.toString();

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
          child: ListView(
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
                    Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: RichText(
                                  text: TextSpan(
                                    // Note: Styles for TextSpans must be explicitly defined.
                                    // Child text spans will inherit styles from parent

                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'We will send you an '),
                                      TextSpan(
                                          text: 'One Time Password ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'on this number '),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _mobilenoController,
                          obscureText: false,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefix: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '(+94) ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.done,
                              color: Colors.green,
                              size: 32,
                            ),
                          ),
                          validator: (value) {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your mobile number';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('images/otpSetup.png'),
                      height: 350.0,
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
                          Navigator.pushNamed(context, OtpVerify.id);
                          print(_mobilenoController.text);
                        },
                        child: Text('Get OTP'),
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
