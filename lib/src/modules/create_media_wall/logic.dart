import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raah_e_roshan/src/modules/create_media_wall/state.dart';

class MediaWallLogic extends GetxController {
  final state = MediaWallState().obs;
  final selectedMealTimings = <String>[].obs;
  // get gallery image
  File? image;

  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      (e) {
        Get.snackbar('Image not picked', e.toString());
        update();
      };
    }
  }

  void clearImage() {
    image = null;
    update(); // Notify listeners that the state has changed
  }
}
