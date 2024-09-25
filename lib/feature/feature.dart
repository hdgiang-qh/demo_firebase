import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Feature {
  final CollectionReference myItem =
      FirebaseFirestore.instance.collection("CURD");

  final databaseRealtime = FirebaseDatabase.instance.ref("Realtime Data");

  Future<void> create({required BuildContext context}) async {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return myDialogCreate(context: contexts);
        });
  }

  Future<void> createRealtime({required BuildContext context}) async {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return myDialogCreateRealtime(context: contexts);
        });
  }

  Future<void> update(
      {required BuildContext context, required var itemUser}) async {
    _controllerNameUpdate.text = itemUser['name'];
    _controllerAgeUpdate.text = itemUser['age'];
    _controllerTitleUpdate.text = itemUser['title'];
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return myDialogUpdate(context: contexts, item: itemUser);
        });
  }

  Future<void> delete({required String id}) async {
    myItem.doc(id).delete();
    await Fluttertoast.showToast(
      msg: "Delete Success",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void addItem() {
    myItem.add({
      'name': _controllerName.text.toString(),
      'age': _controllerAge.text.toString(),
      'title': _controllerTitle.text.toString()
    });
  }

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();

  final TextEditingController _controllerNameRT = TextEditingController();
  final TextEditingController _controllerAgeRT = TextEditingController();
  final TextEditingController _controllerTitleRT = TextEditingController();

  final TextEditingController _controllerNameUpdate = TextEditingController();
  final TextEditingController _controllerAgeUpdate = TextEditingController();
  final TextEditingController _controllerTitleUpdate = TextEditingController();

  Dialog myDialogCreate({required BuildContext context}) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Create User Data",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              TextField(
                controller: _controllerName,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerAge,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerTitle,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0D6EFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () async {
                  if (_controllerName.text.isEmpty ||
                      _controllerTitle.text.isEmpty ||
                      _controllerAge.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Value is Empty",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.red.shade400,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  } else {
                    addItem();
                    Navigator.pop(context);
                    await Fluttertoast.showToast(
                      msg: "Create Success",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  }
                },
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );

  Dialog myDialogCreateRealtime({required BuildContext context}) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Create User Data",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              TextField(
                controller: _controllerNameRT,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerAgeRT,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerTitleRT,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0D6EFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () async {
                  if (_controllerNameRT.text.isEmpty ||
                      _controllerTitleRT.text.isEmpty ||
                      _controllerAgeRT.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Value is Empty",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.red.shade400,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  } else {
                    final id = DateTime.now().microsecondsSinceEpoch.toString();
                    databaseRealtime.child(id).set({
                      'name': _controllerNameRT.text.toString(),
                      'age': _controllerAgeRT.text.toString(),
                      'title': _controllerTitleRT.text.toString()
                    });
                    Navigator.pop(context);
                    await Fluttertoast.showToast(
                      msg: "Create Success",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                    _controllerNameRT.clear();
                    _controllerAgeRT.clear();
                    _controllerTitleRT.clear();
                  }
                },
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );

  Dialog myDialogUpdate({required BuildContext context, required var item}) =>
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Update User Data",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              TextField(
                controller: _controllerNameUpdate,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerAgeUpdate,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controllerTitleUpdate,
                obscureText: false,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0D6EFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () async {
                  if (_controllerNameUpdate.text.isEmpty ||
                      _controllerTitleUpdate.text.isEmpty ||
                      _controllerAgeUpdate.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Value is Empty",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.red.shade400,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  } else {
                    myItem.doc(item.id).update({
                      'name': _controllerNameUpdate.text.toString(),
                      'age': _controllerAgeUpdate.text.toString(),
                      'title': _controllerTitleUpdate.text.toString()
                    });
                    Navigator.pop(context);
                    await Fluttertoast.showToast(
                      msg: "Update Success",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
}
