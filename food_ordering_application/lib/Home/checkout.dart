import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/Home/menu.dart';
import 'package:provider/provider.dart';
import '../cart.dart';
import '../constant.dart';
import 'package:pay/pay.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double quantityPrice;
  String userEmail;
  String fname;
  String lname;
  String fullname;
  String phoneNo;
  String totalPrice;
  String items;
  int orderNum;
  String orderId;
  String currentDate;
  String currentTime;
  List<String> itemsArr = [];
  List<String> itemQuantityArr = [];

  @override
  void initState() {
    super.initState();

    getUserMail();
    totalPrice = Cart.totalPrice.toString();
    getUserInfo();

    itemsArr = [
      for (int i = 0; i < Cart.basketItems.length; i++)
        " ${Cart.basketItems[i].name} * ${Cart.basketItems[i].quantity}  Rs.${Cart.basketItems[i].quantity * Cart.basketItems[i].price}"
    ];
    print(itemsArr);
    itemQuantityArr = [
      for (int i = 0; i < Cart.basketItems.length; i++)
        " ${Cart.basketItems[i].name} * ${Cart.basketItems[i].quantity}"
    ];
    print(itemQuantityArr);
    getCurrentDate();
    getCurrentTime();
  }

  void getCurrentDate() {
    currentDate = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
    print(currentDate);
  }

  void getCurrentTime() {
    currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());
    print(currentTime);
  }

  void getUserMail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  void getUserInfo() {
    FirebaseFirestore.instance
        .collection("userprofile")
        .doc(userEmail)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        fname = documentSnapshot.data()['fname'];
        lname = documentSnapshot.data()['lname'];
        phoneNo = documentSnapshot.data()['mobileno'];
        fullname = "${fname}' '${lname} ";
        print('fname $fname');
        print('fname $phoneNo');
      }
    });
  }

  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '1',
      status: PaymentItemStatus.final_price,
    )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void Pay() {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1219901", // Replace your Merchant ID
      "notify_url": "http://sample.com/notify",
      "order_id": orderId,
      "items": itemsArr,
      "amount": totalPrice,
      "currency": "LKR",
      "first_name": fname,
      "last_name": lname,
      "email": userEmail,
      "phone": phoneNo,
      "address": "",
      "city": "",
      "country": "Sri Lanka",
      // "delivery_address": "No. 46, Galle road, Kalutara South",
      // "delivery_city": "Kalutara",
      // "delivery_country": "Sri Lanka",
      // "custom_1": "",
      // "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      IncreaseOrderNumbers();
      AddOrderDetails();
      AddEachItems();
      setState(() {
        Cart.EmptyCart();
      });

      setState(() {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Menu(),
          ),
        );
      });
    }, (error) {
      print("One Time Payment Failed. Error: $error");
    }, () {
      print("One Time Payment Dismissed");
    });
  }

  void getOrderId() async {
    FirebaseFirestore.instance
        .collection('orders')
        .doc('OrderNumbers')
        .get()
        .then((DocumentSnapshot OrderNo) {
      if (OrderNo.exists) {
        orderNum = OrderNo['lastOrderNumber'];
        orderNum = orderNum + 1;

        orderId = 'ORID' + orderNum.toString();
        print('Order ID: ' + orderId);

        Pay();
      }
    });
  }

  void IncreaseOrderNumbers() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc('OrderNumbers')
        .update({"lastOrderNumber": FieldValue.increment(1)})
        .then((value) => print("Order Number Increased"))
        .catchError((error) => print("Failed: $error"));
  }

  void AddOrderDetails() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set({
          "OrderId": orderId,
          "OrderItems": itemQuantityArr,
          "Time": currentTime,
          "Date": currentDate,
          "Name": fullname,
          "Amount": totalPrice,
          "PhoneNo": phoneNo,
          "Email": userEmail,
          "Status": 'Pending',
        })
        .then((value) => print("Records Added Successfully!"))
        .catchError((error) => print("Failed: $error"));
  }

  void AddEachItems() {
    for (int index = 0; index < Cart.basketItems.length; index++) {
      String addName = Cart.basketItems[index].name;
      double addPrice = Cart.basketItems[index].price;
      int addQuantity = Cart.basketItems[index].quantity;

      print(addName);
      print(addPrice);
      print(addQuantity);
      FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .collection('OrderItems')
          .doc(addName)
          .set({
            "name": addName,
            "price": addPrice,
            "quantity": addQuantity,
          })
          .then((value) => print("Each item added!"))
          .catchError((error) => print("Failed: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Check Out'),
          backgroundColor: kredbackgroundcolor,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Total(${Cart.basketItems.length.toString()}) Items",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                margin: EdgeInsets.only(left: 12, top: 10, bottom: 5),
              ),
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: 500,
                    child: ListView(
                      children: [
                        Builder(
                          builder: (context) {
                            return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: Cart.basketItems.length,
                              itemBuilder: (context, index) {
                                quantityPrice =
                                    Cart.basketItems[index].quantity *
                                        Cart.basketItems[index].price;
                                print(index);
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Text(
                                                Cart.basketItems[index].name,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      " Price: ",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      '${Cart.basketItems[index].quantity.toString()} * ${Cart.basketItems[index].price}',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                '= Rs.$quantityPrice ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Quantity:  ${Cart.basketItems[index].quantity} ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            "Total amount:",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Text(
                            "Rs.${Cart.totalPrice.toString()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: GooglePayButton(
                        width: 150,
                        paymentConfigurationAsset: 'googlepay.json',
                        paymentItems: _paymentItems,
                        style: GooglePayButtonStyle.black,
                        type: GooglePayButtonType.pay,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        getOrderId();
                      },
                      child: FittedBox(
                        child: Container(
                          width: 150,
                          height: 35,
                          child: Image(
                            image: AssetImage('images/payhere.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 16),
              ),
            ],
          ),
        ),
      );
    });
  }
}
