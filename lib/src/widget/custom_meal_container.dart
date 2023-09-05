import 'package:flutter/material.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

// ignore: must_be_immutable
class MealContainer extends StatelessWidget {
  const MealContainer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? AppColors.customThemeColor1
            : AppColors.customShadowColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          // side: BorderSide(color: AppColors.customThemeColor),
        ),
      ),
      child: Text(
        text,
        // style: TextStyle(color: AppColors.customThemeColor),
      ),
    );
  }
}
