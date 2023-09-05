import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/log_in/view.dart';
import 'package:raah_e_roshan/src/widget/custom_bootombar.dart';
import '../../utils/colors.dart';
import 'logic.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final logic = Get.put(SplashscreenLogic());
  final state = Get.find<SplashscreenLogic>().state;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    alreadylogin();

    // Timer(const Duration(seconds: 2), () {
    //   Get.to(const LogIn());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customThemeColor,
      body: Padding(
        padding: EdgeInsets.only(top: 150.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/Group 3.svg',
                // ignore: deprecated_member_use
                color: AppColors.customScaffoldColor,
              ),
            ),
            SizedBox(height: 190.h,),
            if (loading)
           const    CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.customScaffoldColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  ///.......user Already login.........///
  void alreadylogin() {
    final auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 2), () {
        Get.to(const CustomBottomBar());
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Get.to(const LogIn());
      });
    }
  }
}

// class SplashServices {
//   void islogin(BuildContext context) {
//     final auth = FirebaseAuth.instance;
//   }
// }
