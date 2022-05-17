import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';

import 'package:food_ordering_application/model/constant.dart';
import '../widgets/viewvotes.dart';
import '../widgets/voteitem.dart';
import 'package:food_ordering_application/global.dart' as global;

class VoteFood extends StatefulWidget {
  @override
  _VoteFoodState createState() => _VoteFoodState();
}

class _VoteFoodState extends State<VoteFood> {
  @override
  void initState() {
    super.initState();
  }

  // void getVotingDetails() async {
  //   FirebaseFirestore.instance
  //       .collection('votes')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     votelenth = querySnapshot.size;
  //     for (int i = 0; i < querySnapshot.size; i++) {}
  //     querySnapshot.docs.forEach((doc) {
  //       int i = 0;
  //       VItems = [
  //         VoteItem(name: doc["name"], value: double.parse(doc["value"])),
  //       ];
  //       ViewVotes.add(VItems[i]);
  //       print(ViewVotes.getVoteItems[i].name);
  //       i++;
  //     });
  //   });
  // }

  String _value = 'null';
  int votecount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('votes'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 5,
                bottom: 10,
              ),
              child: Text(
                'What would you like to eat for tommorrow?',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("votes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  // if (snapshot.connectionState == ConnectionState.waiting ||
                  //     !snapshot.hasData) {
                  //   //  return CircularProgressIndicator();
                  // }

                  if (snapshot.hasData) {
                    print('has data');
                    return Container(
                      //123,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,

                        // ignore: missing_return
                        itemBuilder: (BuildContext context, index) {
                          QueryDocumentSnapshot category =
                              snapshot.data.docs[index];
                          return Container(
                            child: Card(
                              elevation: 5,
                              child: new InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(category['name']),
                                        leading: Radio(
                                          groupValue: _value,
                                          activeColor: Color(0xFF6200EE),
                                          value: category['name'],
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                              print(_value);
                                              votecount = category['votecount'];
                                              print(votecount.toString());
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: titleColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: global.voteStatus == false
                  ? Container(
                      margin: EdgeInsets.only(top: 15),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Sushi,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                          ),
                          onPressed: () {
                            if (_value != 'null' && votecount != null) {
                              int newVotecount = votecount + 1;
                              FirebaseFirestore.instance
                                  .collection('votes')
                                  .doc(_value)
                                  .update({'votecount': newVotecount}).then(
                                      (value) {
                                print("voted Succesfully!");
                                showAlertDialog(context);
                                setState(() {
                                  global.voteStatus = true;
                                });
                              }).catchError((error) =>
                                      print("Failed to vote: $error"));
                            } else {
                              return null;
                            }
                          },
                          child: Text('Vote'),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Text(
                        'Thank you for voting!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
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
    content: Text('Voted Succesfully!'),
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
