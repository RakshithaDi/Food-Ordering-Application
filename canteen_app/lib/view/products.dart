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
  final TextEditingController _catIdController = TextEditingController();
  bool status = true;
  String foodType = '1';
  String recommendType = 'No';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Form(
                    key: _addproductform,
                    child: Column(
                      children: [
                        Text('add Items'),
                        TextFormField(
                          controller: _catIdController,
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
                          controller: _catIdController,
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
                          controller: _catIdController,
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
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Select Type',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                value: foodType,
                                //hint: Text('Food'),
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                elevation: 16,
                                style: const TextStyle(color: Colors.blueGrey),
                                underline: Container(
                                  height: 2,
                                  color: Colors.red,
                                ),
                                items: const <DropdownMenuItem<String>>[
                                  DropdownMenuItem(
                                    value: '1',
                                    child: Text('Dishes'),
                                  ),
                                  DropdownMenuItem(
                                    value: '2',
                                    child: Text('Bevarages'),
                                  ),
                                  DropdownMenuItem(
                                    value: '3',
                                    child: Text('Burgers'),
                                  ),
                                  DropdownMenuItem(
                                    value: '4',
                                    child: Text('Short Eats'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    foodType = value.toString();
                                    print(foodType);
                                  });
                                },
                              ),
                            ),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),
                        TextFormField(
                          controller: _catIdController,
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
                            Expanded(
                              child: DropdownButton(
                                value: recommendType,
                                //hint: Text('Food'),
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                elevation: 16,
                                style: const TextStyle(color: Colors.blueGrey),
                                underline: Container(
                                  height: 2,
                                  color: Colors.red,
                                ),
                                items: const <DropdownMenuItem<String>>[
                                  DropdownMenuItem(
                                    value: 'Yes',
                                    child: Text('Yes'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'No',
                                    child: Text('No'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    recommendType = value.toString();
                                    print(recommendType);
                                  });
                                },
                              ),
                            ),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Upload Image'),
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            thickness: 2,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    child: Form(
                      key: _searchprodIdform,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Search by product ID'),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _catIdController,
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
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 70, left: 70, top: 20, bottom: 20),
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
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        key: _editform,
                        child: Column(
                          children: [
                            Text('Update Items'),
                            TextFormField(
                              controller: _catIdController,
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
                              controller: _catIdController,
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
                              controller: _catIdController,
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
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton(
                                    value: foodType,
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
                                        value: '1',
                                        child: Text('Dishes'),
                                      ),
                                      DropdownMenuItem(
                                        value: '2',
                                        child: Text('Bevarages'),
                                      ),
                                      DropdownMenuItem(
                                        value: '3',
                                        child: Text('Burgers'),
                                      ),
                                      DropdownMenuItem(
                                        value: '4',
                                        child: Text('Short Eats'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        foodType = value.toString();
                                        print(foodType);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: _catIdController,
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
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton(
                                    value: recommendType,
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
                                        value: 'Yes',
                                        child: Text('Yes'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'No',
                                        child: Text('No'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        recommendType = value.toString();
                                        print(recommendType);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(flex: 3, child: Container()),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Upload Image:'),
                                ),
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 50, left: 50),
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
                                      if (_editform.currentState!.validate()) {
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white))),
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
                        children: [
                          Text('Delete Products'),
                          TextFormField(
                            controller: _catIdController,
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
                                    if (_deleteform.currentState!.validate()) {
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
        ],
      ),
    );
  }
}
