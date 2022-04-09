import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class Messages extends StatefulWidget {
  const Messages({Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void addMessage() {
    FirebaseFirestore.instance
        .collection("messages")
        .doc('rakshitha1@gmail.com')
        .collection('chats')
        .add({
          'userMessage': messageController.text,
          'adminMessage': '',
          'timeStamp': DateTime.now(),
        })
        .then((value) => print("Message added"))
        .catchError((error) => print("Failed to add message: $error"));
    setState(() {
      messageController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Messages'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("messages")
                        .doc('rakshitha1@gmail.com')
                        .collection('chats')
                        .orderBy('timeStamp', descending: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        //  return CircularProgressIndicator();
                      }

                      if (snapshot.hasData) {
                        print('has data');
                        return Container(
                          height:
                              MediaQuery.of(context).size.height / 1.3, //123,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, index) {
                              QueryDocumentSnapshot messages =
                                  snapshot.data.docs[index];
                              Timestamp time = messages['timeStamp'];
                              int millis = time.millisecondsSinceEpoch;
                              var dt =
                                  DateTime.fromMillisecondsSinceEpoch(millis);
                              var d12 = DateFormat('hh:mm a').format(dt);

                              return Column(
                                children: <Widget>[
                                  messages['userMessage'] != ''
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BubbleSpecialThree(
                                              sent: true,
                                              text:
                                                  '${messages['userMessage']}',
                                              color: Color(0xFF1B97F3),
                                              tail: true,
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20, top: 5),
                                              child: Text(
                                                d12,
                                                style: TextStyle(fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  messages['adminMessage'] != ''
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BubbleSpecialThree(
                                              sent: true,
                                              text: messages['adminMessage'],
                                              color: Colors.white,
                                              tail: true,
                                              isSender: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 5),
                                              child: Text(
                                                d12,
                                                style: TextStyle(fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
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
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.black,
                    controller: messageController,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        fillColor: Sushi,
                        filled: true,
                        labelText: 'Enter your message',
                        suffix: IconButton(
                          highlightColor: Sushi,
                          //splashRadius: 30,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              addMessage();
                            } else {
                              return null;
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: titleColor,
                            // size: 35,
                          ),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
