import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/login_OTP/view.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import '../../widget/custom_button.dart';
import '../../widget/item_textfield.dart';
import 'logic.dart';

class LogIn extends StatefulWidget {
  const LogIn({
    super.key,
  });

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final logic = Get.put(LogInLogic());
  final state = Get.find<LogInLogic>().state;
  final _formKey = GlobalKey<FormState>();
  final phonenumberController = TextEditingController();
  final nameController = TextEditingController();
  bool isPhoneNumberValid = false;
  final auth = FirebaseAuth.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref('users');
  // final firebase = FirebaseFirestore.instance.collection('user').snapshots();
  final RxBool loading = false.obs;
  bool isDropdownEmpty = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phonenumberController.dispose();

    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.customThemeColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Stack(
            children: [
              Container(
                height: Get.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/hand-with-coins-economy.jpg'))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 110.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: AnimatedTextKit(animatedTexts: [
                        TyperAnimatedText('Log in!',
                            textStyle: TextStyle(
                                fontSize: 34.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.customScaffoldColor))
                      ]),
                    ),

                    SizedBox(
                      height: 120.h,
                    ),

                    /// all text fields ///
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /// select donor type ///
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            child: Container(
                              height: 38.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.customScaffoldColor,
                                borderRadius: BorderRadius.circular(11.r),
                                border: Border.all(
                                  color: isDropdownEmpty
                                      ? Colors.red
                                      : AppColors.customScaffoldColor,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Row(
                                  children: [
                                    DropdownButton<String>(
                                      underline: const SizedBox(),
                                      // dropdownColor: AppColors.customThemeColor,
                                      borderRadius: BorderRadius.circular(11.r),
                                      icon: Padding(
                                        padding: EdgeInsets.only(left: 70.w),
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          // color: AppColors.customScaffoldColor,
                                        ),
                                      ),
                                      hint: Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Text(
                                          'Select Donor Type',
                                          style: state.selecttextTextstyle,
                                        ),
                                      ),
                                      value: logic.selectedValue,
                                      items: logic.values.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: Text(
                                              value,
                                              style: state.selecttextTextstyle,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          logic.selectedValue =
                                              newValue.toString();
                                          isDropdownEmpty = newValue == null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          ///.....name textfield///
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            child: ItemsTextField(
                              textEditingController: nameController,
                              textInputType: TextInputType.name,
                              helperText: 'Enter Your Name',
                              onChanged: (value) {},
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                }

                                RegExp regex = RegExp(r'^.{3,}$');
                                if (value.isEmpty) {
                                  return ("Please Enter User Name");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Please Enter Valid Name");
                                }

                                return null;
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          ///.... phone number field......///
                          Padding(
                            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                            child: ItemsTextField(
                              textEditingController: phonenumberController,
                              helperText: '+923123456789',
                              textInputType: TextInputType.phone,
                              onChanged: (value) {
                                setState(() {
                                  isPhoneNumberValid = value.isNotEmpty &&
                                      value.trim().length == 13;
                                });
                              },
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }
                                // Add more validation checks if needed.
                                return null; // Return null if the input is valid.
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CustomButton(
                        label: loading.value
                            ? ''
                            : 'Log In', // Hide the label when loading
                        borderRadius: 8.r,
                        backgroundColor: AppColors.customThemeColor,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // Set loading state
                            setState(() {
                              loading.value = true;
                            });

                            try {
                              await auth.verifyPhoneNumber(
                                phoneNumber: phonenumberController.text,
                                verificationCompleted: (_) {
                                  Get.snackbar(
                                    'Verification complete',
                                    '',
                                    borderRadius: 11.r,
                                  );
                                },
                                verificationFailed: (e) {
                                  loading.value = false;
                                  Get.snackbar('Verification Failed', '',
                                      colorText: AppColors.customScaffoldColor,
                                      backgroundColor: Colors.redAccent,
                                      borderRadius: 11.r,
                                      icon: const Icon(
                                        Icons.error_outline,
                                        color: AppColors.customScaffoldColor,
                                      ));
                                },
                                codeSent:
                                    (String verificationId, int? token) async {
                                  Get.to(LogInOTP(
                                    verificationId: verificationId,
                                    phoneNumber: phonenumberController.text,
                                    donerType: logic.selectedValue.toString(),
                                    displayName: nameController.text,
                                  ));

                                  // final SharedPreferences prefs =
                                  //     await SharedPreferences.getInstance();

                                  // prefs.setString('name', nameController.text);
                                  loading.value = false;
                                },
                                codeAutoRetrievalTimeout: (e) {
                                  // This callback is called when the auto-retrieval of the SMS code has timed out
                                  Get.snackbar('Code time out', '',
                                      colorText: AppColors.customScaffoldColor,
                                      backgroundColor: Colors.redAccent,
                                      borderRadius: 11.r,
                                      icon: const Icon(
                                        Icons.error_outline,
                                        color: AppColors.customScaffoldColor,
                                      ));
                                },
                              );
                            } catch (error) {
                              // Handle any errors that occur during the verification process
                            }
                          }
                        },
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customScaffoldColor,
                        ),
                        child: loading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.customScaffoldColor,
                                ),
                              )
                            : null, // Hide the indicator when not loading
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
