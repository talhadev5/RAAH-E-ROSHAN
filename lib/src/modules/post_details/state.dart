import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class PostDetialsState {
  TextStyle? textTextstyle;
  TextStyle? titleTextstyle;
  // TextStyle? posttextTextstyle;
  PostDetialsState() {
    ///
    textTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    titleTextstyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customBlackColor);
 
  }
}
