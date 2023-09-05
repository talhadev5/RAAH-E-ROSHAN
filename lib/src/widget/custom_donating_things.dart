import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_button.dart';

class CustomDonateThings extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String text;

  const CustomDonateThings({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            if (image.isNotEmpty) // Only show the image if the URL is not empty
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  height: 130.h,
                  width: double.infinity,
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Image Not Available', // Display a placeholder text if image URL is empty
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: CustomButton(
                  borderRadius: 8.r,
                  label: 'Donate Now',
                  backgroundColor: AppColors.customThemeColor1,
                  onTap: onTap,
                  labelStyle: TextStyle(
                      color: AppColors.customScaffoldColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
