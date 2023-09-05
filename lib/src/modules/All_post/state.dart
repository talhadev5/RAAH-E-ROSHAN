import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class AllPostState {
  TextStyle? textTextstyle;
  TextStyle? titleTextstyle;
  TextStyle? posttextTextstyle;
  AllPostState() {
    //
    textTextstyle = TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    titleTextstyle = TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
    posttextTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
