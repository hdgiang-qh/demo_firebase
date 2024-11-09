import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSrc extends StatefulWidget {
  const ImageSrc({super.key});

  @override
  State<ImageSrc> createState() => _ImageSrcState();
}

class _ImageSrcState extends State<ImageSrc> {
  final CollectionReference myImage =
  FirebaseFirestore.instance.collection("image");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Loader",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff0D6EFD),
      ),
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder(
          stream: myImage.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No data found'));
            }
            final images = snapshot.data!.docs;
            return Container(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                    var link_image = images[index];
                    return Image.network(link_image['link_image']);
                  },
                ));
          },
        ),
      ),
    );
  }
}
