import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/log_in/state.dart';

class LogInLogic extends GetxController {
  final LogInState state = LogInState();
  
  // bool showValues = false;
 
  String? selectedValue;
  final List<String> values = ['Marquee Donor', 'Individual Person Donor','Admin'];
  
}
