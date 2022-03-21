import 'package:canteen_app/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateAccounts extends StatefulWidget {
  static String id = 'createaccount';
  @override
  _CreateAccountsState createState() => _CreateAccountsState();
}

class _CreateAccountsState extends State<CreateAccounts> {
  final _createUserformKey = GlobalKey<FormState>();
  final _updateUserformKey = GlobalKey<FormState>();
  final _deleteUserformKey = GlobalKey<FormState>();
  final TextEditingController _createUserNameController =
      TextEditingController();
  final TextEditingController _createUserPasswordController =
      TextEditingController();
  final TextEditingController _updateUserNameController =
      TextEditingController();
  final TextEditingController _updateUserPasswordController =
      TextEditingController();
  final TextEditingController _deleteUserPasswordController =
      TextEditingController();
  bool createButton = true;
  bool deleteButton = true;
  bool changeButton = true;

  CollectionReference users = FirebaseFirestore.instance.collection('staff');
  void createUser({required String username, required String password}) async {
    await users
        .doc(username)
        .set({
          'username': username,
          'password': password,
        })
        .then(
          (value) => showAlertDialog(context, 'User added succesfully!'),
        )
        .catchError(
          (error) => showAlertDialog(context, 'Failed to add user!'),
        );
    setState(() {
      createButton = true;
    });
  }

  void updateUser({required String username, required String password}) async {
    await users
        .doc(username)
        .update({'password': password})
        .then((value) =>
            showAlertDialog(context, 'Password updated succesfully!'))
        .catchError(
            (error) => showAlertDialog(context, 'Failed to update password!'));
    setState(() {
      changeButton = true;
    });
  }

  void deleteUser({required String username}) async {
    await users
        .doc(username)
        .delete()
        .then((value) => showAlertDialog(context, 'User Deleted succesfully!'))
        .catchError(
            (error) => showAlertDialog(context, 'Failed to delete user!'));
    setState(() {
      deleteButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Users'),
                          Container(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (BuildContext context, index) {
                                  return Card(
                                    child: Text('name'),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Form(
                        key: _createUserformKey,
                        child: Column(
                          children: [
                            Text('Create Users'),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: TextFormField(
                                controller: _createUserNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Username',
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
                                    return 'Please enter a valid user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: _createUserPasswordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 4) {
                                    return 'Please enter a long password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
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
                                      if (_createUserformKey.currentState!
                                          .validate()) {
                                        createUser(
                                            username:
                                                _createUserNameController.text,
                                            password:
                                                _createUserPasswordController
                                                    .text);
                                        setState(() {
                                          createButton = false;
                                        });
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: createButton == true
                                        ? const Text(
                                            "Create",
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
                      child: Form(
                        key: _updateUserformKey,
                        child: Column(
                          children: [
                            Text('Change Password'),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: TextFormField(
                                controller: _updateUserNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Username',
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
                                    return 'Please enter a valid user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: _updateUserPasswordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 4) {
                                    return 'Please enter a long password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
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
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide(color: Colors.grey)),
                                    ),
                                    onPressed: () async {
                                      if (_updateUserformKey.currentState!
                                          .validate()) {
                                        updateUser(
                                            username:
                                                _updateUserNameController.text,
                                            password:
                                                _updateUserPasswordController
                                                    .text);
                                        setState(() {
                                          changeButton = false;
                                        });
                                      } else {
                                        return null;
                                      }

                                      //
                                    },
                                    child: changeButton == true
                                        ? const Text(
                                            "Change",
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
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Form(
                  key: _deleteUserformKey,
                  child: Column(
                    children: [
                      Text('Delete User'),
                      TextFormField(
                        controller: _deleteUserPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Username',
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
                            return 'Please enter a valid user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0),
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
                                    side: BorderSide(color: Colors.grey)),
                              ),
                              onPressed: () async {
                                if (_deleteUserformKey.currentState!
                                    .validate()) {
                                  deleteUser(
                                    username:
                                        _deleteUserPasswordController.text,
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
            ),
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
