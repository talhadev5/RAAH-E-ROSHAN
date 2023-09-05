import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class AllPostLogic extends GetxController {
  final AllPostState state = AllPostState();
  RxString imagepath = ''.obs;
  Future picimage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagepath.value = image.path.toString();
    }
  }
}
