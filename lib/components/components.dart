import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../startingScreen/loginScreen.dart';

InputDecoration customElevate(String title, IconData icon) {
  return InputDecoration(
    hintText: title,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueAccent,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    prefixIcon: Icon(icon),
  );
}

Future<String> uploadimg() async {
  String? imageUrl;
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  print('${file?.path}');
  if (file == null) return "";

  String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referanceDirImages = referenceRoot.child('images');
  Reference referanceimgtoupload = referanceDirImages.child(uniqueFilename);

  try {
    await referanceimgtoupload.putFile(File(file.path));
    imageUrl = await referanceimgtoupload.getDownloadURL();
    print('here its done');
  } catch (e) {
    print('error in try');
    print(e);
  }
  return '$imageUrl';
}

AppBar custombar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.white,
        size: 40.0,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout!!'),
              content: Text('Are You Sure To Logout'),
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAllNamed(LoginScreen.id);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    ],
    centerTitle: true,
    title: const Text(
      'GVM',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
    ),
    backgroundColor: const Color(0xFF7BE3FA),
  );
}
