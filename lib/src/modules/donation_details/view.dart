import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_button.dart';
import '../payment_method/view.dart';
import 'logic.dart';

class DonationDetails extends StatelessWidget {
  final String image;
  final String titletext;

  final String discriptiontext;

  DonationDetails({
    super.key,
    required this.image,
    required this.titletext,
    required this.discriptiontext,
   
  });
  final logic = Get.put(DonationDetailsLogic());
  final state = Get.find<DonationDetailsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                  height: Get.height * .35,
                  width: double.infinity,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                top: 20.h,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.customScaffoldColor,
                    )),
              ),
            
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Row(
              children: [
                Text(
                  'Title',
                  style: state.titleTextstyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Text(titletext),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Row(
              children: [
                Text(
                  'Overview',
                  style: state.titleTextstyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Text(discriptiontext),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: CustomButton(
                borderRadius: 8.r,
                label: 'Donate',
                backgroundColor: AppColors.customThemeColor1,
                onTap: () {
                  Get.to(const Paymentmethod());
                },
                labelStyle: TextStyle(
                    color: AppColors.customScaffoldColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
