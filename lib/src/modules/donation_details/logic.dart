import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:raah_e_roshan/src/modules/donation_details/state.dart';

class DonationDetailsLogic extends GetxController {
  final DonationDetailsState state = DonationDetailsState();
  List<Map<String, dynamic>> detaillist = [
    {
      'overview':
          'Donation for needy families is a charitable initiative that aims to provide essential support and assistance to families facing financial hardships and difficult circumstances. This philanthropic effort is driven by individuals, organizations, and communities who understand the importance of helping those less fortunate and in need of basic necessities.The objective of donation campaigns for needy families is to alleviate their burden and improve their living conditions by providing them with essential items, such as food, clothing, shelter, medical supplies, educational resources, and other critical necessities. These families may be experiencing financial challenges due to various factors, such as unemployment, natural disasters, health crises, or economic hardships.'
    }
  ];
}
