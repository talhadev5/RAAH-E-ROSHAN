import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class CreatePostState {
  TextStyle? buttontextTextStyle;
  TextStyle? textTextStyle;
  TextStyle? posttextTextstyle;
  CreatePostState() {
    //
    buttontextTextStyle = TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    textTextStyle = TextStyle(
        fontSize: 16.sp,
        // fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);

    posttextTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
