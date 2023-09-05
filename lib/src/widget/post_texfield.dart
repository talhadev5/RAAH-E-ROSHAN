import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class PostTextField extends StatelessWidget {
  // final dynamic sufixixIcon;

  const PostTextField({
    Key? key,
    this.helperText,
    this.maxLength,
    this.optional = false,
    this.textEditingController,
    this.textInputType,
    this.onTogglePasswordStatus,
    this.inputFormatter,
    this.validate,
    // required this.sufixixIcon,
  }) : super(key: key);
  final String? helperText;
  final int? maxLength;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final VoidCallback? onTogglePasswordStatus;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String?)? validate;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: maxLength,
        controller: textEditingController,
        validator: (value) {
          if (optional) return null;
          if ((value ?? "").isEmpty) {
            return 'Field is required';
          }

          return null;
        },
        keyboardType: textInputType,
        style: const TextStyle(
            // color: AppColors.customThemeColor,
            // fontSize: 20.sp,
            ),
        cursorColor: AppColors.customThemeColor,
        decoration: InputDecoration(
          hintText: helperText ?? 'Enter Your Post',
          hintStyle: TextStyle(
            // color: AppColors.customThemeColor,
            fontSize: 15.sp,
          ),
          // suffixIcon: sufixixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          focusColor: AppColors.customThemeColor,
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(11.r),
          //     borderSide: const BorderSide(
          //       color: AppColors.customThemeColor,
          //     )),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.customThemeColor,
          )),
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(11.r),
          //     borderSide: const BorderSide(
          //       color: AppColors.customThemeColor,
          //     )
          //     ),
          errorBorder: const UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: const UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
