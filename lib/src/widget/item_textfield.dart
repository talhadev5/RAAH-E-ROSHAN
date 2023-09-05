import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class ItemsTextField extends StatelessWidget {
  // final dynamic prefixIcon;

  const ItemsTextField({
    Key? key,
    this.helperText,
    this.maxLength,
    this.optional = false,
    this.textEditingController,
    this.textInputType,
    this.onTogglePasswordStatus,
    this.inputFormatter,
    this.validate,
    required Null Function(dynamic value) onChanged,
    // required this.prefixIcon,
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
        controller: textEditingController,
        validator: (value) {
          if (optional) return null;
          if ((value ?? "").isEmpty) {
            return 'Field is required';
          }

          return null;
        },
        keyboardType: textInputType,
        style: TextStyle(
          // color: AppColors.customScaffoldColor,
          fontSize: 16.sp,
          // fontWeight: FontWeight.w500
        ),
        cursorColor: AppColors.customBlackTextColor2,
        decoration: InputDecoration(
          hintText: helperText ?? '',
          fillColor: AppColors.customScaffoldColor, filled: true,
          hintStyle: TextStyle(
            // color: AppColors.customScaffoldColor,
            fontSize: 15.sp,
          ),
          // prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          focusColor: AppColors.customScaffoldColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide:
                  const BorderSide(color: AppColors.customScaffoldColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide:
                  const BorderSide(color: AppColors.customScaffoldColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: const BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
