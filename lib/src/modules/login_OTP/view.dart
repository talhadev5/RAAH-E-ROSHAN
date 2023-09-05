import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_bootombar.dart';
import 'package:raah_e_roshan/src/widget/custom_button.dart';
import 'logic.dart';

class LogInOTP extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String donerType;
  final String displayName;
  const LogInOTP({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.donerType,
    required this.displayName,
  });

  @override
  State<LogInOTP> createState() => _LogInOTPState();
}

class _LogInOTPState extends State<LogInOTP> {
  final logic = Get.put(LogInOTPLogic());

  final state = Get.find<LogInOTPLogic>().state;

  final codeController = TextEditingController();

  final FocusNode pinPutFocusNode = FocusNode();
  final phonenumberController = TextEditingController();
  final nameController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final RxBool loading = false.obs;
  bool isWaiting = false;
  int remainingTime = 50; // Initial time in seconds
  bool isCountdownActive = true;

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          isCountdownActive = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.customThemeColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: Get.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/labour-pain-humanity-poor.jpg'))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 110.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w),
                      child: AnimatedTextKit(animatedTexts: [
                        TyperAnimatedText('Verification!',
                            textStyle: TextStyle(
                                fontSize: 34.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.customScaffoldColor))
                      ]),
                    ),

                    SizedBox(
                      height: 90.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.h),
                      child: Row(
                        children: [
                          Text(
                            "Enter a 6-digit OTP Code",
                            style: state.textTextstyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Pinput(
                      length: 6,
                      keyboardType: TextInputType.number,
                      controller: codeController,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      textInputAction: TextInputAction.next,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        height: 40.h,
                        width: 45.w,
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.customScaffoldColor,
                        ),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.customScaffoldColor,
                          ),
                        ),
                        // Change the color when selected
                      ),
                      validator: (e) {
                        if (kDebugMode) {
                          print('validating code: $e');
                        }
                        return null;
                      },
                      onCompleted: (pin) => {},
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "If you don not recevie a verification code",
                            style: state.textTextstyle,
                          ),
                        ],
                      ),
                    ),

                    /// resend button ///
                    Padding(
                      padding: EdgeInsets.only(left: 160.w),
                      child: TextButton(
                          onPressed: isCountdownActive
                              ? null
                              : () {
                                  // ignore: unused_element
                                  void sendVerificationCodeAgain() {
                                    // Implement your logic to send the verification code again
                                    // For example:
                                    // 1. Call your API or service to send the verification code
                                    // 2. Handle the response, update UI if needed
                                    // 3. Start the countdown timer again

                                    // Simulating a delay for demonstration purposes
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        // Reset the countdown timer
                                        isCountdownActive = true;
                                        remainingTime = 50;
                                        startCountdown();
                                      });
                                    });
                                  }
                                },
                          child: Text(
                            isCountdownActive
                                ? "Resend Code  $remainingTime"
                                : "Resend Code",
                            style: TextStyle(
                              color: isCountdownActive
                                  ? Colors.grey
                                  : AppColors.customThemeColor,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.h, right: 8.h),
                      child: CustomButton(
                        borderRadius: 8.r,
                        label: isWaiting
                            ? ''
                            : 'Verify', // Hide the label when waiting
                        backgroundColor: AppColors.customThemeColor,
                        onTap: () async {
                          if (isWaiting) {
                            return; // Return early if waiting
                          }

                          setState(() {
                            isWaiting = true; // Set the flag to true
                          });

                          final credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: codeController.text,
                          );

                          try {
                            await auth.signInWithCredential(credential);
                            // log(widget.donerType);
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .set({
                              'username': widget.displayName,
                              'phone number': widget.phoneNumber,
                              'donorType': widget.donerType,
                              'uid': auth.currentUser!.uid,
                            });

                            Get.snackbar(
                                'Congratulation', 'Your Login Successful',
                                backgroundColor: AppColors.customScaffoldColor
                                    .withOpacity(0.5),
                                borderRadius: 11.r,
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: AppColors.customScaffoldColor,
                                ));

                            Get.to(const CustomBottomBar());
                          } catch (e) {
                            Get.snackbar('OTP Code Invalid', '',
                                colorText: AppColors.customScaffoldColor,
                                backgroundColor: Colors.redAccent,
                                borderRadius: 11.r,
                                icon: const Icon(
                                  Icons.error_outline,
                                  color: AppColors.customScaffoldColor,
                                ));
                          } finally {
                            setState(() {
                              isWaiting = false; // Set the flag back to false
                            });
                          }
                        },
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customScaffoldColor,
                        ),
                        child: isWaiting
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.customScaffoldColor,
                                ),
                              )
                            : null, // Hide the indicator when not waiting
                      ),
                    ),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
