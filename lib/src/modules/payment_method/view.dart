import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raah_e_roshan/src/modules/payment_method/logic.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_button.dart';
import 'package:raah_e_roshan/src/widget/payment_card.dart';

class Paymentmethod extends StatefulWidget {
  const Paymentmethod({super.key});

  @override
  State<Paymentmethod> createState() => _PaymentmethodState();
}

class _PaymentmethodState extends State<Paymentmethod> {
  final logic = Get.put(PaymentmethodLogic());

  final state = Get.find<PaymentmethodLogic>().state;
  File? selectedImage;
  bool isAccountNumberCopied = false;
  bool isImageUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.customThemeColor),
        backgroundColor: AppColors.customScaffoldColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text(
              'Payment',
              style: state.titleTextstyle,
            ),
            SizedBox(
              height: 30.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              child: const Text(
                'After sending money to one of the given account numbers,you have to upload the receipt image.',
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: logic.bankaccounts.length,
              itemBuilder: (BuildContext context, int index) {
                return Pyamentcrad(
                  title: logic.bankaccounts[index]['title'],
                  accountnumber: logic.bankaccounts[index]['accountnumber'],
                  accountowner: logic.bankaccounts[index]['ownername'],
                  image: logic.bankaccounts[index]['image'],
                );
              },
            ),
            const SizedBox(height: 20),
            // Upload button and selected image display
            GestureDetector(
              onTap: () async {
                final imageFile =
                    // ignore: deprecated_member_use
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (imageFile != null) {
                  setState(() {
                    selectedImage = File(imageFile.path);
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isAccountNumberCopied || selectedImage != null
                      ? AppColors.customThemeColor
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
                child: const Text(
                  'Upload Receipt',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      width: double.infinity,
                      height: Get.height * 0.3,
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.fitWidth,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  if (selectedImage != null)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = null;
                          });
                        },
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            if (selectedImage != null) SizedBox(height: 10.h),

            selectedImage != null
                ? isImageUploading
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.customThemeColor,
                        )),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        child: CustomButton(
                          borderRadius: 8.r,
                          label: 'Submit',
                          backgroundColor: AppColors.customThemeColor,
                          onTap: () async {
                            setState(() {
                              isImageUploading = true;
                            });

                            String imageUrl = await logic
                                .uploadImageToStorage(selectedImage!);
                            await logic.saveImageUrlToFirestore(imageUrl);

                            setState(() {
                              isImageUploading = false;
                              selectedImage = null;
                            });

                            Get.snackbar('Congratulations',
                                'Image uploaded successfully');
                          },
                          labelStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customScaffoldColor,
                          ),
                        ),
                      )
                : const SizedBox(),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
