import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        primary: false,
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("complaints").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              //  return CircularProgressIndicator();
            }

            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  QueryDocumentSnapshot complaintes =
                      snapshot.data!.docs[index];
                  String formatedDate;

                  Timestamp timestamp = complaintes['time'];
                  DateTime dateTime = timestamp.toDate();
                  String formatDate =
                      DateFormat.yMMMd().add_jm().format(dateTime);
                  formatedDate = formatDate;

                  return Card(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text('Type',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex: 15,
                                  child: Text(': ${complaintes['type']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 1,
                                    child: Text('Complaint',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                  flex: 15,
                                  child: Text(': ${complaintes['Complaint']},',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text('Date',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex: 15,
                                  child: Text(': ${formatedDate}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
