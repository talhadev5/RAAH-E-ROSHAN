import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class DonationDetailsState {
  TextStyle? textTextstyle;
  TextStyle? titleTextstyle;
  DonationDetailsState() {
    //
    textTextstyle = TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customScaffoldColor);
    titleTextstyle = TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
    }
}
