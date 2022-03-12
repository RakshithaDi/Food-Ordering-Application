import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering_application/Authentication/otp_verify.dart';
import 'package:food_ordering_application/Authentication/signup.dart';
import 'package:food_ordering_application/constant.dart';
import 'package:food_ordering_application/registeruser.dart';
import '../main.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OtpSetup extends StatefulWidget {
  static String id = 'otp_setup';
  @override
  _OtpSetupState createState() => _OtpSetupState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _OtpSetupState extends State<OtpSetup> {
  String email;
  bool showLoading = false;
  String verifiatoinId;
  String mob;
  String countryMobNo;
  final _formKey = GlobalKey<FormState>();
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController _mobilenoController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      email = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  Future<void> verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+94${_mobilenoController.text}",
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
        print('OTP Verified Automatically!');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Signup(_mobilenoController.text)));

        // signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      //2.verificationFailed
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          showAlertDialog('Invalid Phone Number provided', context);
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
        //showAlertDialog('Time Out Waiting for SMS. Try Again', context);
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
      print(email);
      if (authCredential?.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Signup(_mobilenoController.text)));
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
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'We will send you an ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9))),
                      TextSpan(
                          text: 'One Time Password ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9))),
                      TextSpan(
                        text: 'on your Mobile number ',
                        style: TextStyle(
                            fontSize: 16, color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 80,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _mobilenoController,
                  obscureText: false,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.4),
                    labelText: "Enter Your Number",
                    errorStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(
                        fontSize: 15, color: Colors.white.withOpacity(0.9)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '(+94) ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.done,
                      color: Colors.white,
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
            Container(
              child: Column(
                children: [
                  Container(
                    child: Image(
                      color: Colors.white.withOpacity(0.9),
                      image: AssetImage('images/otpimg.png'),
                      height: 350.0,
                      width: 300.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.red)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              showLoading = true;
                              mob = _mobilenoController.text;
                              countryMobNo = '+94$mob';
                            });
                            verifyPhoneNumber();
                            print('controller');
                            print(_mobilenoController.text);
                          } else {
                            return null;
                          }
                        },
                        child: Text('Get OTP'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    var text = RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Enter the ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          TextSpan(
            text: 'OTP ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          TextSpan(
            text: 'sent to ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          TextSpan(
            text: '+94${mob.substring(1)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: text,
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 100, right: 100),
                    child: TextFormField(
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _otpController,
                      obscureText: false,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      decoration: InputDecoration(
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white.withOpacity(0.4),
                        labelText: 'Enter OTP',
                        errorStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(
                            fontSize: 15, color: Colors.white.withOpacity(0.9)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
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
                      'Didn\'t receive the OTP? ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'RESEND OTP',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        verifyPhoneNumber();
                        showAlertDialog('OTP Sent Again!', context);
                        print('OTP Sent Back');
                        print(_mobilenoController.text);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('images/otp.png'),
                  height: 300.0,
                  width: 300.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: SizedBox(
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
              ),
            ],
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
          centerTitle: true,
          title: Text('OTP Verification'),
          backgroundColor: kredbackgroundcolor,
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
        backgroundColor: Colors.redAccent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFEf44949),
            Color(0xFFEf00e0e),
            Color(0xFFEEc00b0b),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black38,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
        ),
      ),
    );
  }
}

void logout() async {
  await FirebaseAuth.instance.signOut();
  streamController.add('2');
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
