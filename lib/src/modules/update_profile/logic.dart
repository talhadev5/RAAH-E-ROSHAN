import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'state.dart';

class UpdateProfileLogic extends GetxController {
  final firestore = FirebaseFirestore.instance.collection('users');
    final auth = FirebaseAuth.instance;
  final UpdateProfileState state = UpdateProfileState();

File? profileimage;
  final picker = ImagePicker();
  void uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profileImages')
          .child(auth.currentUser!.uid);
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();

      // Update the user's Firestore document with the new profile image URL.
      await firestore.doc(auth.currentUser!.uid).update({
        'profileImage': imageUrl,
      });
    }
  }

  }
  
  
  


