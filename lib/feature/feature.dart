import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Feature {
  final CollectionReference myItem =
      FirebaseFirestore.instance.collection("CURD");

  Future<void> create({required BuildContext context}) async {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return myDialogCreate(context: contexts);
        });
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
}
