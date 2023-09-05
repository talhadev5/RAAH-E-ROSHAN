import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

class LogInOTPState {
  TextStyle? textTextstyle;
   TextStyle? buttontextTextstyle;
  TextStyle? numberTextstyle;
  LogInOTPState() {
    ///Initialize variables
    textTextstyle = TextStyle(
        fontSize: 12.sp,
        // fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
       buttontextTextstyle = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    numberTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
  }
}
