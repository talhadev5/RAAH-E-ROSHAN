import 'package:get/get.dart';

import 'state.dart';

class DashBoardLogic extends GetxController {
  final DashBoardState state = DashBoardState();
  List<Map<String, dynamic>> listpicture = [
    {'image': 'assets/food donate.jpg'},
    {'image': 'assets/cash donate.jpg'},
    {'image': 'assets/clothing.jpg'},
    {'image': 'assets/food.jpg'}
  ];
}
