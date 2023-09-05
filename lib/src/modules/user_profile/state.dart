import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class UserProfileState {
  TextStyle? titleTextStyle;
  TextStyle? nameTextStyle;
  TextStyle? textTextStyle;
  UserProfileState() {
    ///
    titleTextStyle = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    );
    nameTextStyle = TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customBlackColor);
  }
}
