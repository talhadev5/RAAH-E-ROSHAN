import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class DashBoardState {
  TextStyle? textTextstyle;
  TextStyle? titleTextstyle;
  TextStyle? drawertextTextstyle;
  TextStyle? hadingtextTextstyle;
  DashBoardState() {
    textTextstyle = TextStyle(
        fontSize: 16.sp,
        // fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);

    titleTextstyle = TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.customScaffoldColor);
    drawertextTextstyle = TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
       );
    hadingtextTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customTextColor1);
  }
}
