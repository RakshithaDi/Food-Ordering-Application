import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final _addproductform = GlobalKey<FormState>();
  final _editform = GlobalKey<FormState>();
  final _deleteform = GlobalKey<FormState>();
  final _searchprodIdform = GlobalKey<FormState>();
  final TextEditingController _searchProductIdController =
      TextEditingController();
  String addfoodType = '1';
  String addrecommendType = 'no';
  late String addImg;
  bool addButton = true;
  bool updateButton = true;
  bool deleteButton = true;
  bool status = true;
  final TextEditingController _addProductIdController = TextEditingController();
  final TextEditingController _addProductNameController =
      TextEditingController();
  final TextEditingController _addDescriptionController =
      TextEditingController();
  final TextEditingController _addpriceController = TextEditingController();
  String updaterecommendType = 'no';
  late String updateImg;
  String updatefoodType = '1';
  final TextEditingController _updateProductIdController =
      TextEditingController();
  final TextEditingController _updateProductNameController =
      TextEditingController();
  final TextEditingController _updateDescriptionController =
      TextEditingController();
  final TextEditingController _updatepriceController = TextEditingController();
  final TextEditingController _deleteProductController =
      TextEditingController();
  bool imgUploading = false;
  bool imgupdateUploading = false;
  String imgUrl = '';
  String updateImgUrl = '';
  Uint8List? file;
  String fileName = '';
  String updatefileName = '';
  CollectionReference items = FirebaseFirestore.instance.collection('items');
  void addProduct(
      {required int productId,
      required String productName,
      required String description,
      required int categoryType,
      required String price,
      required String recommendTyep,
      required String image}) async {
    await items
        .doc(productId.toString())
        .set({
          'id': productId,
          'name': productName,
          'description': description,
          'categoryId': categoryType,
          'price': price,
          'recommend': recommendTyep,
          'imgUrl': image,
          'rating': 1.5,
        })
        .then(
          (value) => showAlertDialog(context, 'Product added succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to add product!'),
        );
    setState(() {
      addButton = true;
    });
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

  Future updateSelectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      file = result!.files.first.bytes;
      updatefileName = result.files.first.name;
    });
    print(updatefileName);
    setState(() {
      imgupdateUploading = true;
    });

    updateUploadImage();
  }

  Future<void> updateUploadImage() async {
    try {
      final ref = await FirebaseStorage.instance
          .ref()
          .child("test/$updatefileName")
          .putData(file!);
      final url = await ref.ref.getDownloadURL();
      print(url);
      updateImageUrlLink(url);
    } on FirebaseException catch (e) {
      print('image upload error');
    }
  }

  void updateImageUrlLink(String url) async {
    setState(() {
      updateImgUrl = url;
    });
    print('dffffffffff $updateImgUrl');
    setState(() {
      imgupdateUploading = false;
    });
  }

  void updateProduct(
      {required int productId,
      required String productName,
      required String description,
      required int categoryType,
      required String price,
      required String recommendTyep,
      required String image}) async {
    await items
        .doc(productId.toString())
        .update({
          'id': productId,
          'name': productName,
          'description': description,
          'categoryId': categoryType,
          'price': price,
          'recommend': recommendTyep,
          'imgUrl': image,
          'rating': 1.5
        })
        .then(
          (value) => showAlertDialog(context, 'Product updated succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to update product!'),
        );
    setState(() {
      updateButton = true;
    });
  }

  void deletCategory({required int prodId}) async {
    await items
        .doc(prodId.toString())
        .delete()
        .then(
            (value) => showAlertDialog(context, 'Product Deleted succesfully!'))
        .catchError(
            (error) => showAlertDialog(context, 'Failed to delete product!'));
    setState(() {
      deleteButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          'Items',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(left: 10),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          primary: false,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("items")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                //  return CircularProgressIndicator();
                              }

                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    QueryDocumentSnapshot item =
                                        snapshot.data!.docs[index];

                                    return Card(
                                      child: InkWell(
                                        onTap: () {
                                          _deleteProductController.text =
                                              item['id'].toString();
                                          _updateProductIdController.text =
                                              item['id'].toString();
                                          _updateProductNameController.text =
                                              item['name'];
                                          _updateDescriptionController.text =
                                              item['description'];

                                          _updatepriceController.text =
                                              item['price'];

                                          setState(() {
                                            updateImgUrl = item['imgUrl'];
                                            updatefoodType =
                                                item['categoryId'].toString();
                                            updaterecommendType =
                                                item['recommend'];
                                          });
                                          print('dsfsfsfs $updatefoodType');
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Image.network(
                                                  item['imgUrl'],
                                                  height: 50,
                                                  width: 100,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'Id:',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              item['id']
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'Name:',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              item['name'],
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 2,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Form(
                key: _addproductform,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Add Items',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      controller: _addProductIdController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Product Id',
                        labelStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a product id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _addProductNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Name',
                        labelStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _addDescriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Description',
                        labelStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Select Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("categories")
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !snapshot.hasData) {
                              //  return CircularProgressIndicator();
                            }
                            if (snapshot.hasData) {
                              List<DropdownMenuItem<String>> categories = [];
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                DocumentSnapshot cat = snapshot.data!.docs[i];
                                categories.add(
                                  DropdownMenuItem(
                                    child: Text(cat['name']),
                                    value: cat['id'].toString(),
                                  ),
                                );
                              }
                              return DropdownButton(
                                value: addfoodType,
                                //hint: Text('Food'),
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                elevation: 16,
                                style: const TextStyle(color: Colors.blueGrey),
                                underline: Container(
                                  height: 2,
                                  color: Colors.red,
                                ),
                                items: categories,
                                onChanged: (value) {
                                  setState(() {
                                    addfoodType = value.toString();
                                    print(addfoodType);
                                  });
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
                        Expanded(flex: 2, child: Container()),
                      ],
                    ),
                    TextFormField(
                      controller: _addpriceController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Price',
                        labelStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Recommend',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButton(
                          value: addrecommendType,
                          //hint: Text('Food'),
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.blueGrey),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          items: const <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              value: 'yes',
                              child: Text('Yes'),
                            ),
                            DropdownMenuItem(
                              value: 'no',
                              child: Text('No'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              addrecommendType = value.toString();
                              print(addrecommendType);
                            });
                          },
                        ),
                        Expanded(flex: 2, child: Container()),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                selectImage();
                              },
                              child: Text('Upload Image'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: (file == null)
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Select an Image',
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : Text(fileName),
                        ),
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
                        onPressed: () async {
                          if (_addproductform.currentState!.validate()) {
                            addProduct(
                                productId:
                                    int.parse(_addProductIdController.text),
                                productName: _addProductNameController.text,
                                description: _addDescriptionController.text,
                                categoryType: int.parse(addfoodType),
                                price: _addpriceController.text,
                                recommendTyep: addrecommendType,
                                image: imgUrl);
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 2,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Form(
                        key: _searchprodIdform,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                'Search by product ID',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _searchProductIdController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Search Product Id',
                                  labelStyle: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a product id';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 30, right: 30),
                                child: SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_searchprodIdform.currentState!
                                            .validate()) {
                                        } else {
                                          return null;
                                        }

                                        //
                                      },
                                      child: status == true
                                          ? const Text(
                                              "Search",
                                            )
                                          : const CircularProgressIndicator(
                                              backgroundColor: Colors.black38,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Form(
                        key: _editform,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: const Text(
                                'Update Items',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              controller: _updateProductIdController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Product Id',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a product id';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _updateProductNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter product name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _updateDescriptionController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Description',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Select Type',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("categories")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }

                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        !snapshot.hasData) {
                                      //  return CircularProgressIndicator();
                                    }
                                    if (snapshot.hasData) {
                                      List<DropdownMenuItem<String>>
                                          updatecategories = [];
                                      for (int i = 0;
                                          i < snapshot.data!.docs.length;
                                          i++) {
                                        DocumentSnapshot cat =
                                            snapshot.data!.docs[i];
                                        updatecategories.add(
                                          DropdownMenuItem(
                                            child: Text(cat['name']),
                                            value: cat['id'].toString(),
                                          ),
                                        );
                                      }
                                      return DropdownButton(
                                        value: updatefoodType,
                                        //hint: Text('Food'),
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.blueGrey),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.red,
                                        ),
                                        items: updatecategories,
                                        onChanged: (value) {
                                          setState(() {
                                            updatefoodType = value.toString();
                                            print(updatefoodType);
                                          });
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
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: _updatepriceController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Price',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter price';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Recommend',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DropdownButton(
                                  value: updaterecommendType,
                                  //hint: Text('Food'),
                                  icon: const Icon(
                                      Icons.arrow_drop_down_outlined),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.blueGrey),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.red,
                                  ),
                                  items: const <DropdownMenuItem<String>>[
                                    DropdownMenuItem(
                                      value: 'yes',
                                      child: Text('Yes'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'no',
                                      child: Text('No'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      updaterecommendType = value.toString();
                                      print(updaterecommendType);
                                    });
                                  },
                                ),
                                Expanded(flex: 3, child: Container()),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        updateSelectImage();
                                      },
                                      child: Text('Upload Image'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: (file == null)
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'Select an Image',
                                            textAlign: TextAlign.left,
                                          ),
                                        )
                                      : Text(updatefileName),
                                ),
                              ],
                            ),
                            imgupdateUploading == false
                                ? Container()
                                : const SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_editform.currentState!
                                            .validate()) {
                                          updateProduct(
                                              productId: int.parse(
                                                  _updateProductIdController
                                                      .text),
                                              productName:
                                                  _updateProductNameController
                                                      .text,
                                              description:
                                                  _updateDescriptionController
                                                      .text,
                                              categoryType:
                                                  int.parse(updatefoodType),
                                              price:
                                                  _updatepriceController.text,
                                              recommendTyep:
                                                  updaterecommendType,
                                              image: updateImgUrl);
                                          setState(() {
                                            updateButton = false;
                                          });
                                        } else {
                                          return null;
                                        }

                                        //
                                      },
                                      child: updateButton == true
                                          ? const Text(
                                              "Update",
                                            )
                                          : const CircularProgressIndicator(
                                              backgroundColor: Colors.black38,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Form(
                      key: _deleteform,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delete Products',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: _deleteProductController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Product Id',
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a category ID';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(right: 50, left: 50),
                              child: SizedBox(
                                width: 100,
                                height: 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_deleteform.currentState!
                                          .validate()) {
                                        deletCategory(
                                            prodId: int.parse(
                                                _deleteProductController.text));

                                        setState(() {
                                          deleteButton = false;
                                        });
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: deleteButton == true
                                        ? const Text(
                                            "Delete",
                                          )
                                        : const CircularProgressIndicator(
                                            backgroundColor: Colors.black38,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
