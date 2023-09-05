import 'dart:io';
import 'package:get/get.dart';

import 'state.dart';

class PostDetialsLogic extends GetxController {
  final state = PostDetialsState().obs;

  File? image;
  
// Future<void> markPostAsAccepted(Map<String, dynamic> postData) async {
//   final postsCollection = FirebaseFirestore.instance.collection('posts');
//   await postsCollection.doc(postData['postId']).update({'accepted': true});
// }

}
