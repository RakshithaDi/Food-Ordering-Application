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
  final _addproductform = GlobalKey<FormState>();
  bool status = true;
  final TextEditingController _catIdController = TextEditingController();
  final TextEditingController _catnameController = TextEditingController();

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
                        child: ListView(
                          children: [
                            ListView.builder(
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
                                              children: [
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
                          ],
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
                          controller: _catIdController,
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
                          controller: _catIdController,
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
                                  } else {
                                    return null;
                                  }

                                  //
                                },
                                child: status == true
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
                        controller: _catIdController,
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
                        controller: _catIdController,
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
                                } else {
                                  return null;
                                }

                                //
                              },
                              child: status == true
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
                        controller: _catIdController,
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
                                } else {
                                  return null;
                                }

                                //
                              },
                              child: status == true
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
}
