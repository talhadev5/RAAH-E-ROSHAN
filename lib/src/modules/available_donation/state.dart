import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class AvailableDonationState {
  TextStyle? textTextstyle;
  TextStyle? titleTextstyle;


  AvailableDonationState() {
    ///
    textTextstyle = TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    titleTextstyle = TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
    
  }
}
