import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constant.dart';
import '../controller/item.dart';

class Votes extends StatefulWidget {
  const Votes({Key? key}) : super(key: key);

  @override
  _VotesState createState() => _VotesState();
}

class _VotesState extends State<Votes> {
  @override
  void initState() {
    super.initState();
    fetchdate();
  }

  List<String> _items = [];
  final form = GlobalKey<FormState>();
  bool addButton = true;
  final TextEditingController _itemNameController = TextEditingController();
  CollectionReference items = FirebaseFirestore.instance.collection('votes');
  void deletCategory(String itemName) async {
    await items
        .doc(itemName)
        .delete()
        .then((value) => showAlertDialog(context, 'item Deleted succesfully!'))
        .catchError(
            (error) => showAlertDialog(context, 'Failed to delete product!'));
  }

  void fetchdate() async {
    await FirebaseFirestore.instance
        .collection('votes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
        print(doc["votecount"]);
        _items = ['fsf', 'fsf', 'fsfs'];
      });
    });
  }

  void addItem() async {
    await items
        .doc(_itemNameController.text)
        .set({
          'name': _itemNameController.text,
          'votecount': 0,
        })
        .then(
          (value) => showAlertDialog(context, 'Item added succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to add the item!'),
        );
    setState(() {
      addButton = true;
    });
  }

  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    print(_items);
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: form,
                        child: Column(
                          children: [
                            Container(
                              child: const Text(
                                'Add food item to vote',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: titleColor),
                              ),
                              margin: EdgeInsets.only(left: 10, bottom: 20),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: TextFormField(
                                controller: _itemNameController,
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                    color: titleColor,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.3),
                                  labelText: 'Name',
                                  labelStyle: fstlyepromptTextFields,
                                  border: InputBorder.none,
                                ),
                                autocorrect: false,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the food item name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  right: 50, left: 50, top: 10),
                              child: SizedBox(
                                width: 100,
                                height: 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (form.currentState!.validate()) {
                                        setState(() {
                                          addItem();
                                          addButton = false;
                                        });
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: addButton == true
                                        ? const Text(
                                            "Add",
                                          )
                                        : const CircularProgressIndicator(
                                            backgroundColor: Colors.black38,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: const Text(
                              'Items to vote',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: titleColor),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("votes")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                //  return CircularProgressIndicator();
                              }

                              if (snapshot.hasData) {
                                return Container(
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        QueryDocumentSnapshot data =
                                            snapshot.data!.docs[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 50,
                                          child: Card(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        data['name'],
                                                        style:
                                                            fstlyepromptTextFields,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.highlight_remove,
                                                        color: Colors.red,
                                                      ),
                                                      tooltip: 'Remove',
                                                      onPressed: () {
                                                        setState(() {
                                                          deletCategory(
                                                              data['name']);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections()),
                            )),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  showAlertDialog(BuildContext context, message) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      //title: Text("Log Out"),
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
