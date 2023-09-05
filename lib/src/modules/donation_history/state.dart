import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

class DonationHistoryState {
  TextStyle? titletextTextstyle;
  TextStyle? textTextstyle;

  DonationHistoryState() {
    ///Initialize variables
    titletextTextstyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );
    textTextstyle = TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.customThemeColor1
    );
  }
}
