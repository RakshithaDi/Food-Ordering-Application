import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering_application/Authentication/otp_verify.dart';
import 'package:food_ordering_application/constant.dart';
import 'package:food_ordering_application/registeruser.dart';

import '../Home/home.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OtpSetup extends StatefulWidget {
  static String id = 'otp_setup';
  final int mobileno;
  OtpSetup(this.mobileno);
  @override
  _OtpSetupState createState() => _OtpSetupState(this.mobileno);
}

class _OtpSetupState extends State<OtpSetup> {
  bool showLoading = false;
  String verifiatoinId;
  int mobileno;
  String mob;
  String countryMobNo;
  final _formKey = GlobalKey<FormState>();
  _OtpSetupState(this.mobileno);
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController _mobilenoController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: countryMobNo,
      //1.verificationCompleted
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          showLoading = true;
        });
        // ANDROID ONLY!
        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
        setState(() {
          showLoading = false;
        });
        print('User Sign in Successfully!');

        // signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      //2.verificationFailed
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(e.message)));

          setState(() {
            showLoading = false;
          });
        }
        // Handle other errors
      },
      //3.codeSent
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        // String smsCode = 'xxxx';
        // // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);
        // // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
        setState(() {
          showLoading = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          this.verifiatoinId = verificationId;
        });
        print(countryMobNo);
        print('code sent');
      },
      //4.timeout
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  Future<void> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog('Invalid OTP Code!', context);
      print(_otpController.text);
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    _mobilenoController.text = mobileno.toString();

    return SafeArea(
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
                            padding: const EdgeInsets.only(left: 20, right: 20),
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
                  child: Form(
                    key: _formKey,
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
                      setState(() {
                        showLoading = true;
                        mob = _mobilenoController.text;
                        countryMobNo = '+94$mob';
                      });
                      verifyPhoneNumber();
                      print('controller');
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
    );
  }

  getOtpFormWidget(context) {
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
              text: '$countryMobNo',
              style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
    return SafeArea(
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
                Form(
                  key: _formKey,
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _otpController,
                      obscureText: false,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'OTP Number',
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        // suffixIcon: Icon(
                        //   Icons.error,
                        // ),
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
                          return 'Please enter the OTP';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t receive the OTP? ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'RESEND OTP',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0XFFD8352C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          verifyPhoneNumber();
                          showAlertDialog('OTP Sent Back', context);
                          print('verify');
                          print(_mobilenoController.text);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )
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
                      if (_formKey.currentState.validate()) {
                        final phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verifiatoinId,
                                smsCode: _otpController.text);
                        signInWithPhoneAuthCredential(phoneAuthCredential);
                      } else {
                        return null;
                      }
                    },
                    child: Text('Verify & Proceed'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
              setState(() {
                showLoading = false;
                currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
              });
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
        ),
        backgroundColor: kbackgroundcolor,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
        ),
      ),
    );
  }
}

showAlertDialog(String message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert Box"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
