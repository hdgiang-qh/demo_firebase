import 'package:flutter/material.dart';

import '../feature/feature.dart';

class RealtimeHome extends StatefulWidget {
  const RealtimeHome({super.key});

  @override
  State<RealtimeHome> createState() => _RealtimeHomeState();
}

class _RealtimeHomeState extends State<RealtimeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Realtime Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff0D6EFD),
      ),
      body: SafeArea(child: Container()),
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
