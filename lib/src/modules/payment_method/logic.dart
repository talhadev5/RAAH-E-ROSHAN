import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'state.dart';

class PaymentmethodLogic extends GetxController {
  final PaymentmethodState state = PaymentmethodState();

  List<Map<String, dynamic>> bankaccounts = [
    {
      'title': 'EasyPaisa',
      'ownername': 'Muhammad Talha',
      'accountnumber': '923411827155',
      'image': 'assets/Easypaisa.png'
    },
    {
      'title': 'Sada Pay',
      'ownername': 'Muhammad Talha Saleem',
      'accountnumber': '923411827155',
      'image': 'assets/download (1).jpeg'
    },
    {
      'title': 'Meezan Bank',
      'ownername': 'RAAH-E-ROSHAN',
      'accountnumber': 'PK12345234564569',
      'image': 'assets/3-2.jpg'
    },
  ];
  File? selectedImage;

  Future<String> uploadImageToStorage(File image) async {
    final Reference storageRef = FirebaseStorage.instance.ref().child('users');
    final TaskSnapshot uploadTask = await storageRef.putFile(image);
    final String imageUrl = await uploadTask.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    final CollectionReference paymentCollection =
        FirebaseFirestore.instance.collection('users');

    await paymentCollection.add({
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
