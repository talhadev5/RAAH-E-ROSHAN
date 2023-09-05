import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
    this.borderRadius,
    required this.labelStyle,
    this.child,
  }) : super(key: key);

  final String? label;
  final Color? backgroundColor;
  final TextStyle labelStyle;
  final Function? onTap;
  final double? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          color: backgroundColor,
        ),
        child: SizedBox(
          height: 45, // Adjust height as needed
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: child == null, // Show child when null
                child: Text(
                  label!,
                  style: labelStyle,
                ),
              ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
