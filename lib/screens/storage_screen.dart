import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  User? user;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Storage Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImage();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(230, 45)),
              ),
              child: const Text("Pick Images"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                sendFile();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(230, 45)),
              ),
              child: const Text("Send Data"),
            ),
          ],
        ),
      ),
    );
  }

  pickImage() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  sendFile() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final mountainsRef = storageRef.child("mountains.jpg");
      // final mountainImagesRef = storageRef.child("images/mountains.jpg");
      await mountainsRef.putFile(File(image!.path));
    } catch (e) {
      debugPrint("Error ------------>>> $e ");
    }
  }
}
