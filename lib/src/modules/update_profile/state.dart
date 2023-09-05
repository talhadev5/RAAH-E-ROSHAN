import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class UpdateProfileState {
  TextStyle? appbartextTextStyle;
  TextStyle? textbuttonTextStyle;

  UpdateProfileState() {
    ///
    appbartextTextStyle = TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    textbuttonTextStyle = const TextStyle(
        // fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
