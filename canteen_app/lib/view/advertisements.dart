import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Advertisements extends StatefulWidget {
  const Advertisements({Key? key}) : super(key: key);

  @override
  _AdvertisementsState createState() => _AdvertisementsState();
}

class _AdvertisementsState extends State<Advertisements> {
  @override
  void initState() {
    super.initState();
    getAdsLinks();
  }

  String imgLink = '';
  final List<String> imgList = [];
  List<Widget> imageSliders = [];
  final CarouselController _controller = CarouselController();
  int _current = 0;
  bool addButton = true;
  bool updateButton = true;
  bool deleteButton = true;
  bool imgUploading = false;
  bool imgupdateUploading = false;
  String imgUrl = '';
  String updateImgUrl = '';
  Uint8List? file;
  String fileName = '';
  String updatefileName = '';
  void getAdsLinks() async {
    await FirebaseFirestore.instance
        .collection('advertisments')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        imgList.add(doc["imgUrl"]);
      });
    });
    setState(() {
      addAdsToSlider();
    });
  }

  void addAdsToSlider() {
    imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  Future selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      file = result!.files.first.bytes;
      fileName = result.files.first.name;
    });
    print(fileName);
    setState(() {
      imgUploading = true;
    });

    uploadImage();
  }

  Future<void> uploadImage() async {
    try {
      final ref = await FirebaseStorage.instance
          .ref()
          .child("test/$fileName")
          .putData(file!);
      final url = await ref.ref.getDownloadURL();
      print(url);
      imageUrlLink(url);
    } on FirebaseException catch (e) {
      print('image upload error');
    }
  }

  void imageUrlLink(String url) async {
    setState(() {
      imgUrl = url;
    });
    print('dffffffffff $imgUrl');
    setState(() {
      imgUploading = false;
    });
  }

  void deleteAnAd({required String imgLink}) async {
    await FirebaseFirestore.instance
        .collection("advertisments")
        .where("imgUrl", isEqualTo: imgLink)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
      showAlertDialog(context, 'Ad Deleted succesfully!');
    }).catchError((error) => showAlertDialog(context, 'Failed to delete Ad!'));
    // await FirebaseFirestore.instance
    //     .collection('Advertisments')
    //     .where('imgUrl' isEqualTo:  'dd')
    //     .delete()
    //     .then((value) => showAlertDialog(context, 'Ad Deleted succesfully!'))
    //     .catchError(
    //         (error) => showAlertDialog(context, 'Failed to delete Ad!'));
    setState(() {
      deleteButton = true;
    });
  }

  void addAds({required imgLink}) async {
    await FirebaseFirestore.instance
        .collection('advertisments')
        .add({
          'imgUrl': imgLink,
        })
        .then(
          (value) => showAlertDialog(context, 'Ad added succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to add ad!'),
        );
    setState(() {
      addButton = true;
      imgList.removeRange(0, imgList.length);
      imageSliders.removeRange(0, imageSliders.length);
      getAdsLinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height / 2.9,
                      width: MediaQuery.of(context).size.width / 0.8,
                      child: CarouselSlider(
                        items: imageSliders,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                                imgLink = imgList[index];
                                print(imgList[index]);
                              });
                            }),
                      ),
                    ),
                    IconButton(
                        iconSize: 30,
                        color: Colors.red,
                        tooltip: 'Remove',
                        onPressed: () {
                          deleteAnAd(imgLink: imgLink);
                        },
                        icon: Icon(Icons.highlight_remove)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            print(entry.value);
                            _controller.animateToPage(entry.key);
                            imgLink = entry.value;
                          },
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : titleColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 50,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: lightGreen,
                          ),
                          onPressed: () {
                            selectImage();
                          },
                          child: Text('Upload a new Ad'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      (file == null)
                          ? const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Select an Image',
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Text(fileName),
                    ],
                  ),
                  imgUploading == false
                      ? Container()
                      : const SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 50, left: 50),
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
                            if (file != null) {
                              addAds(imgLink: imgUrl);
                              setState(() {
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white))),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
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
        setState(() {
          imgList.removeRange(0, imgList.length);
          imageSliders.removeRange(0, imageSliders.length);
          getAdsLinks();
        });
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
