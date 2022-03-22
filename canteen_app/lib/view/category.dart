import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final _addcategoryform = GlobalKey<FormState>();
  final _updatecategoryform = GlobalKey<FormState>();
  final _deletecategoryform = GlobalKey<FormState>();
  final _searchprodIdform = GlobalKey<FormState>();
  final TextEditingController _addcatIdController = TextEditingController();
  final TextEditingController _addcatnameController = TextEditingController();
  final TextEditingController _updatecatIdController = TextEditingController();
  final TextEditingController _updatenameController = TextEditingController();
  final TextEditingController _deletecatIdController = TextEditingController();
  late String imgUrl;
  bool addButton = true;
  bool updateButton = true;
  bool deleteButton = true;
  CollectionReference category =
      FirebaseFirestore.instance.collection('categories');
  void createCategory(
      {required String catid,
      required String catname,
      required String imgUrl}) async {
    await category
        .doc(catid)
        .set({
          'id': catid,
          'name': catname,
          'imgUrl': imgUrl,
        })
        .then(
          (value) => showAlertDialog(context, 'Category added succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to add category!'),
        );
    setState(() {
      addButton = true;
    });
  }

  void updateCategory(
      {required String catid,
      required String catname,
      required String imgUrl}) async {
    await category
        .doc(catid)
        .update({
          'id': catid,
          'name': catname,
          'imgUrl': imgUrl,
        })
        .then(
          (value) => showAlertDialog(context, 'Category added succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to add category!'),
        );
    setState(() {
      updateButton = true;
    });
  }

  void deletCategory({required String catid}) async {
    await category
        .doc(catid)
        .delete()
        .then((value) =>
            showAlertDialog(context, 'Category Deleted succesfully!'))
        .catchError(
            (error) => showAlertDialog(context, 'Failed to delete category!'));
    setState(() {
      deleteButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('View Categories'),
                      Container(
                        height: 300,
                        child: SingleChildScrollView(
                          primary: false,
                          child: StreamBuilder<QuerySnapshot>(
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
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    QueryDocumentSnapshot category =
                                        snapshot.data!.docs[index];

                                    return Card(
                                      child: InkWell(
                                        onTap: () {
                                          _updatecatIdController.text =
                                              category['id'].toString();
                                          _updatenameController.text =
                                              category['name'];
                                          _deletecatIdController.text =
                                              category['id'].toString();
                                          imgUrl = category['imgUrl'];
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Image.network(
                                                  category['imgUrl'],
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text('Id:'),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                category['id']
                                                                    .toString()),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                                category[
                                                                    'name']),
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
                ),
                Expanded(
                  child: Form(
                    key: _addcategoryform,
                    child: Column(
                      children: [
                        Text('Add new Category'),
                        TextFormField(
                          controller: _addcatIdController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Category Id',
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
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _addcatnameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Category Name',
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
                              return 'Please enter category name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Upload Image'),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 50, left: 50),
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
                                  if (_addcategoryform.currentState!
                                      .validate()) {
                                    createCategory(
                                        catid: _addcatIdController.text,
                                        catname: _addcatnameController.text,
                                        imgUrl:
                                            'https://media.istockphoto.com/photos/absurdly-small-diet-meal-picture-id182147903?k=20&m=182147903&s=612x612&w=0&h=P9Xp6NxI3_UEiedwYXkvIpcnxow63cG_BZCXntLUK5M=');
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
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white))),
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
        VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _updatecategoryform,
                  child: Column(
                    children: [
                      Text('Update Category'),
                      TextFormField(
                        controller: _updatecatIdController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Category Id',
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
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: _updatenameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Category Name',
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
                            return 'Please enter category name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Upload Image:'),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 50, left: 50),
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
                                if (_updatecategoryform.currentState!
                                    .validate()) {
                                  updateCategory(
                                      catid: _updatecatIdController.text,
                                      catname: _updatenameController.text,
                                      imgUrl:
                                          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500');
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _deletecategoryform,
                  child: Column(
                    children: [
                      Text('Delete Category'),
                      TextFormField(
                        controller: _deletecatIdController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Category Id',
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
                      SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.only(right: 50, left: 50),
                        child: SizedBox(
                          width: 100,
                          height: 50,
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
                                if (_deletecategoryform.currentState!
                                    .validate()) {
                                  deletCategory(
                                    catid: _deletecatIdController.text,
                                  );
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ))
      ],
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
