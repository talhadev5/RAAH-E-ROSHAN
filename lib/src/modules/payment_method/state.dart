import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class PaymentmethodState {
  TextStyle? textTextstyle;
  TextStyle? titleTextstyle;
  TextStyle? accountnumberTextstyle;
  PaymentmethodState() {
    ///
    textTextstyle = TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.customBlackColor);
    accountnumberTextstyle = const TextStyle(
      // fontSize: 14.sp,
      // fontWeight: FontWeight.w500,
      color: AppColors.customThemeColor1,
    );

    titleTextstyle = TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
