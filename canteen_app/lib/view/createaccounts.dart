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
  final TextEditingController _deleteUserNameController =
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
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: const Text(
                              'Users',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("staff")
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
                                          height: 50,
                                          child: Card(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _updateUserNameController
                                                      .text = data['username'];
                                                  _deleteUserNameController
                                                      .text = data['username'];
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  data['username'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
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
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Form(
                      key: _createUserformKey,
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: const Text(
                              'Create Users',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
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
                          const SizedBox(height: 20.0),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: _createUserPasswordController,
                              obscureText: true,
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
                          const SizedBox(height: 20.0),
                          Container(
                            alignment: Alignment.center,
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
                                      side:
                                          const BorderSide(color: Colors.grey),
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
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: const Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
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
                          const SizedBox(height: 20.0),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: _updateUserPasswordController,
                              obscureText: true,
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
                          const SizedBox(height: 20.0),
                          Container(
                            alignment: Alignment.center,
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
                                        side: const BorderSide(
                                            color: Colors.grey)),
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
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                child: Form(
                  key: _deleteUserformKey,
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 10, bottom: 30),
                        child: const Text(
                          'Delete User',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: _deleteUserNameController,
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
                      const SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.center,
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
                                    side: const BorderSide(color: Colors.grey)),
                              ),
                              onPressed: () async {
                                if (_deleteUserformKey.currentState!
                                    .validate()) {
                                  deleteUser(
                                    username: _deleteUserNameController.text,
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
