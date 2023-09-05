import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

class MediaWallState {
  TextStyle? appbartextTextStyle;
  TextStyle? posttextTextstyle;
  MediaWallState() {
    //
    appbartextTextStyle = TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    posttextTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
