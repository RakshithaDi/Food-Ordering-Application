import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_ordering_application/model/constant.dart';

import 'home.dart';

class Complaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() {
    if (formkey.currentState.validate()) {
      print("not validated");
    } else {
      print("validated");
    }
  }

  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TextEditingController ComplaintDescription = new TextEditingController();

  String time;
  String complaintType = 'Food';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Date Today ' + dateToday.toString());

    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Report Complaint'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    color: titleColor,
                    image: AssetImage('images/complaint.png'),
                    height: 160.0,
                    width: 200.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Text(
                      'Select Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DropdownButton(
                        value: complaintType,
                        //hint: Text('Food'),
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        elevation: 16,
                        style: const TextStyle(color: Colors.blueGrey),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: 'Food',
                            child: Text('Food'),
                          ),
                          DropdownMenuItem(
                            value: 'Canteen',
                            child: Text('Canteen'),
                          ),
                          DropdownMenuItem(
                            value: 'Staff',
                            child: Text('Staff'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            complaintType = value;
                            print(complaintType);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Complaint',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                TextFormField(
                  controller: ComplaintDescription,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: titleColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Enter your complaint",
                    labelStyle: TextStyle(
                        fontSize: 15,
                        color: titleColor,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter the Complaint';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 80.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonTheme(
                      height: 40,
                      disabledColor: Colors.grey,
                      child: RaisedButton(
                        color: Sushi,
                        disabledElevation: 4.0,
                        onPressed: () async {
                          if (formkey.currentState.validate()) {
                            FirebaseFirestore.instance
                                .collection("complaints")
                                .add({
                                  "type": complaintType,
                                  "Complaint": ComplaintDescription.text,
                                  "time": FieldValue.serverTimestamp(),
                                })
                                .then((value) => showAlertDialog(
                                    'Complain Reported Successfully!', context))
                                .catchError((error) => showAlertDialog(
                                    'Complain can not be report!', context));
                          } else {
                            return null;
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  showAlertDialog(String message, BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        ComplaintDescription.text = '';
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
}
