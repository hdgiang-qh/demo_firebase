import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../feature/feature.dart';

class RealtimeHome extends StatefulWidget {
  const RealtimeHome({super.key});

  @override
  State<RealtimeHome> createState() => _RealtimeHomeState();
}

class _RealtimeHomeState extends State<RealtimeHome> {
  final databaseRealtime = FirebaseDatabase.instance.ref("Realtime Data");
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    updateItemCount();
  }

  Future<void> updateItemCount() async {
    DatabaseEvent event = await databaseRealtime.once();
    if (event.snapshot.value != null && event.snapshot.value is Map) {
      setState(() {
        itemCount = (event.snapshot.value as Map).length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Realtime Home ($itemCount)",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff0D6EFD),
      ),
      body: SafeArea(
          child: FirebaseAnimatedList(
              query: databaseRealtime,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(
                      snapshot.child("name").value.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.child("age").value.toString()),
                        Text(snapshot.child("title").value.toString())
                      ],
                    ),
                    trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text("Edit"),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Feature().updateRealtime(
                                      context: context,
                                      itemUser: snapshot.value,
                                      keyId: snapshot.key.toString());
                                },
                              )),
                              PopupMenuItem(
                                  child: ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text("Delete"),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Feature().deleteRT(id: snapshot.key!);
                                },
                              )),
                            ]),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Feature().createRealtime(context: context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
