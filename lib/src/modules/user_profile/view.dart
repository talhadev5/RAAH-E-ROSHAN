import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/donation_history/view.dart';
import 'package:raah_e_roshan/src/modules/log_in/view.dart';
import 'package:raah_e_roshan/src/modules/update_profile/view.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../utils/colors.dart';
import 'logic.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
  UserProfile({
    super.key,
  });
  final logic = Get.put(UserProfileLogic());
  final state = Get.find<UserProfileLogic>().state;
  final auth = FirebaseAuth.instance;

  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');

  // final firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.customThemeColor,
      body: Column(
        children: [
          // SizedBox(
          //   height: 45.h,
          // ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: Get.height * .24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/volunteer-giving-box-with-donations-another-volunteer.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 115.h,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      55.r,
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.customScaffoldColor,
                      radius: 50.r,
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(auth.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return const Text('User data not found');
                          }

                          // Now you can access data from snapshot
                          Map<String, dynamic> userData =
                              snapshot.data!.data() as Map<String, dynamic>;

                          // Check if profileImage is null or empty, if so, show asset image
                          if (userData['profileImage'] == null ||
                              userData['profileImage'].isEmpty) {
                            return Image.asset(
                              'assets/profile.png',
                              color: AppColors.customThemeColor1,
                              fit: BoxFit.fill,
                            );
                          } else {
                            return Image.network(
                              userData['profileImage'],
                              fit: BoxFit.fill,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///.............///
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(auth.currentUser?.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Text('Error occurred');
              }

              if (!snapshot.data!.exists) {
                return const Text('User data not found');
              }

              Map<String, dynamic> userData =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (userData.containsKey('username')) {
                return ListTile(
                  title: Center(
                    child: Text(
                      userData['username'].toString(),
                      style: state.nameTextStyle,
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      userData['donorType'].toString(),
                      // style: state.nameTextStyle,
                    ),
                  ),
                );
              } else {
                return const Text('Username not found');
              }
            },
          ),
          SizedBox(
            height: 20.h,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: InkWell(
              onTap: () => {Get.to(const UpdateProfile())},
              child: Container(
                height: Get.height * 0.05,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                        style: BorderStyle.solid,
                        width: 1,
                        color: AppColors.customThemeColor)),
                child: Center(
                    child: Text('Eidit Profile', style: state.titleTextStyle)),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          /// manage admin conditions ///
          auth.currentUser!.phoneNumber == '+923411827155'
              ? Container()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: InkWell(
                        onTap: () => {Get.to(DonationHistory())},
                        child: Container(
                          height: Get.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: AppColors.customThemeColor)),
                          child: Center(
                              child: Text('Donation History',
                                  style: state.titleTextStyle)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: InkWell(
                        onTap: () async {
                          const phoneNumber = '+923411827155';
                          const phoneUrl = 'tel:$phoneNumber';

                          if (kDebugMode) {
                            print('Launching phone call');
                          }

                          // ignore: deprecated_member_use
                          if (await canLaunch(phoneUrl)) {
                            if (kDebugMode) {
                              print('Launching phone app');
                            }
                            // ignore: deprecated_member_use
                            await launch(phoneUrl);
                          } else {
                            if (kDebugMode) {
                              print('Could not launch phone call');
                            }
                          }

                          // Replace with the correct phone number
                          // ignore: use_build_context_synchronously
                          logic.showContactBottomSheet(context, phoneNumber);
                        },
                        child: Container(
                          height: Get.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 1,
                              color: AppColors.customThemeColor,
                            ),
                          ),
                          child: Center(
                            child:
                                Text('Contact Us', style: state.titleTextStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 20.h,
          ),

          ///
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: InkWell(
              onTap: () => {
                Get.bottomSheet(BottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(
                            width: 2, color: AppColors.customThemeColor)),
                    enableDrag: false,
                    onClosing: () {},
                    builder: (BuildContext buildContext) {
                      return SizedBox(
                        height: Get.height * .4,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ImageIcon(
                              const AssetImage(
                                'assets/logout_182448.png',
                              ),
                              color: AppColors.customThemeColor,
                              size: 70.sp,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Are you sure you wnat to log out of this device',
                              style: state.textTextStyle,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 90.w),
                              child: InkWell(
                                onTap: () => {
                                  auth.signOut().then((value) {
                                    Get.to(const LogIn());
                                  }).onError((error, stackTrace) {
                                    Get.snackbar('Log out Unsuccessful',
                                        error.toString());
                                  })
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
                                  child: Center(
                                      child: Text('Log out',
                                          style: state.titleTextStyle)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 90.w),
                              child: InkWell(
                                onTap: () => {Get.back()},
                                child: Container(
                                  height: Get.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: AppColors.customThemeColor)),
                                  child: Center(
                                      child: Text('Cancel',
                                          style: state.titleTextStyle)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }))
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
                    Center(child: Text('LogOut', style: state.titleTextStyle)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
