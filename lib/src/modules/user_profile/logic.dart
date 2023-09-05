import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raah_e_roshan/src/modules/user_profile/state.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileLogic extends GetxController {
  final UserProfileState state = UserProfileState();

  File? profileimage;
  final picker = ImagePicker();
  Future getProfileGalleryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
    } else {
      (e) {
        Get.snackbar('Image not picked', e.toString());
        update();
      };
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return {}; // Return an empty map if the document doesn't exist
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user data: $error');
      }
      return {}; // Return an empty map on error
    }
  }

  void showContactBottomSheet(BuildContext context, String phoneNumber) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
        // side: const BorderSide(
        //   width: 2,
        //   color: AppColors.customThemeColor,
        // ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Contact Number: ',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    )),
                Text(' 923411827155',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.customThemeColor)),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 110.w),
              child: InkWell(
                onTap: () async {
                  // ignore: deprecated_member_use
                  if (await canLaunch('tel:$phoneNumber')) {
                    // ignore: deprecated_member_use
                    await launch('tel:$phoneNumber');
                  } else {
                    if (kDebugMode) {
                      print('Cannot launch phone dialer');
                    }
                  }
                },
                child: Container(
                  height: Get.height * 0.05,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.customThemeColor)),
                  child:
                      Center(child: Text('Call', style: state.titleTextStyle)),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }
}
