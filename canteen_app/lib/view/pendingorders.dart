import 'package:flutter/material.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text('Pending Orders'),
                SingleChildScrollView(
                  primary: false,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
                                    height: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: const [
                                      Text('Id:'),
                                      Text('name:'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Order Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Text('Order ID:'),
                      ],
                    ),
                  ),
                  Text('Date'),
                  Text('Time:'),
                  Text('Name:'),
                  Text('Phone No:'),
                  Text('Email:'),
                  Text('Item Description:'),
                  Text('Prisce:'),
                  Container(
                    margin: const EdgeInsets.only(right: 50, left: 50),
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onPressed: () async {},
                        child: status == true
                            ? const Text(
                                "Collected",
                              )
                            : const CircularProgressIndicator(
                                backgroundColor: Colors.black38,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
