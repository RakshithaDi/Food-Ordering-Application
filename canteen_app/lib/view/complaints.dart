import 'package:flutter/material.dart';

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
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, index) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: const [
                          Text('Type:'),
                          Text('Complaint:'),
                          Text('TimeStamp:'),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
