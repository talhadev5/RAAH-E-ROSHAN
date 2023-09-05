import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../modules/dashboard/logic.dart';

class CustomDonation extends StatelessWidget {
  final String image;
  CustomDonation({super.key, required this.image});
  final logic = Get.put(DashBoardLogic());
  final state = Get.find<DashBoardLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150.h,
      // width: 275.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(11.r),
      ),
    );
  }
}
