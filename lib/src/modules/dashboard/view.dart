import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/All_post/view.dart';
import 'package:raah_e_roshan/src/modules/available_donation/view.dart';
import 'package:raah_e_roshan/src/modules/create_media_wall/view.dart';
import 'package:raah_e_roshan/src/modules/dashboard/logic.dart';
import 'package:raah_e_roshan/src/modules/donation_details/view.dart';
import 'package:raah_e_roshan/src/modules/notification_page/view.dart';
import 'package:raah_e_roshan/src/modules/user_profile/view.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_donating_things.dart';
import 'package:raah_e_roshan/src/widget/custom_donation_container.dart';
import '../log_in/view.dart';

// ignore: must_be_immutable
class DashBoard extends StatelessWidget {
  DashBoard({
    super.key,
  });
  final logic = Get.put(DashBoardLogic());
  final state = Get.find<DashBoardLogic>().state;
  final auth = FirebaseAuth.instance;
  // final GlobalKey<ScaffoldState> _key = GlobalKey();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        // key: _key,
        drawer: Drawer(
          elevation: 0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: Get.height * .25,
                    width: double.infinity,
                    decoration:
                        const BoxDecoration(color: AppColors.customThemeColor1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 110.h),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(55.r),
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
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              auth.currentUser!.phoneNumber == '+923411827155'
                  ? ListTile(
                      leading: const Icon(
                        Icons.perm_media_outlined,
                        color: AppColors.customThemeColor1,
                      ),
                      title: Text(
                        'Create Media Wall',
                        style: state.drawertextTextstyle,
                      ),
                      onTap: () {
                        Get.to(const MediaWall());
                      },
                    )
                  : ListTile(
                      leading: const Icon(
                        Icons.person_outline_outlined,
                        color: AppColors.customThemeColor1,
                      ),
                      title: Text(
                        'Profile',
                        style: state.drawertextTextstyle,
                      ),
                      onTap: () {
                        Get.to(UserProfile());
                      },
                    ),

              ///  admin manage condition ///
              ListTile(
                leading: const Icon(
                  Icons.paid_outlined,
                  color: AppColors.customThemeColor1,
                ),
                title: Text(
                  'Latest Donations',
                  style: state.drawertextTextstyle,
                ),
                onTap: () {
                  Get.to(const AvailableDonation());
                },
              ),
              auth.currentUser!.phoneNumber == '+923411827155'
                  ? ListTile(
                      leading: const Icon(
                        Icons.notifications_none_outlined,
                        color: AppColors.customThemeColor1,
                      ),
                      title: Text(
                        'Notifications',
                        style: state.drawertextTextstyle,
                      ),
                      onTap: () {
                        Get.to(const NotificationPage());
                      },
                    )
                  : const SizedBox(),

              ///  admin manage condition ///
              auth.currentUser!.phoneNumber == '+923411827155'
                  ? ListTile(
                      leading: const Icon(
                        Icons.post_add_outlined,
                        color: AppColors.customThemeColor1,
                      ),
                      title: Text(
                        'User Posts',
                        style: state.drawertextTextstyle,
                      ),
                      onTap: () {
                        Get.to(const AllPost());
                      },
                    )
                  : ListTile(
                      leading: const Icon(
                        Icons.phone_outlined,
                        color: AppColors.customThemeColor1,
                      ),
                      title: Text(
                        'Contact Us',
                        style: state.drawertextTextstyle,
                      ),
                      onTap: () {
                        // Handle drawer item click
                      },
                    ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.customThemeColor1,
                ),
                title: Text(
                  'Log Out',
                  style: state.drawertextTextstyle,
                ),
                onTap: () {
                  auth.signOut().then((value) {
                    Get.to(const LogIn());
                  }).onError((error, stackTrace) {
                    Get.snackbar('Log out Unsuccessful', error.toString());
                  });
                },
              ),
            ],
          ),
        ),

        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.customThemeColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.customThemeColor,
                child: SvgPicture.asset(
                  'assets/Group 3.svg',
                  // ignore: deprecated_member_use
                  color: AppColors.customScaffoldColor,
                  // fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: Get.height * .23,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.r),
                            bottomRight: Radius.circular(60.r)),
                        color: AppColors.customThemeColor),
                    child: Column(
                      children: [
                        ListTile(
                          title: AnimatedTextKit(animatedTexts: [
                            TyperAnimatedText('Welcome,',
                                textStyle: state.titleTextstyle)
                          ]),
                          subtitle: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(auth.currentUser?.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
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
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userData['username'].toString(),
                                    style: state.textTextstyle,
                                  ),
                                );
                              } else {
                                return const Text('Username not found');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: CarouselSlider.builder(
                      itemCount: logic.listpicture.length,
                      itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) =>
                          CustomDonation(
                              image: logic.listpicture[index]['image']),
                      options: CarouselOptions(
                        height: 155.h,
                        // initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              ),

              /// .........Post Container.......///
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest Update',
                      style: state.hadingtextTextstyle,
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('admin').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text('Error occurred');
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Text('No data');
                  }

                  return Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot adminPostData =
                                snapshot.data!.docs[index];

                            // Ensure the required fields exist before accessing them

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomDonateThings(
                                onTap: () {
                                  Get.to(DonationDetails(
                                    image: adminPostData['Imageurl'],
                                    titletext: adminPostData['Title'],
                                    discriptiontext:
                                        adminPostData['Discription'],
                                  ));
                                },
                                image: adminPostData['Imageurl'].toString(),
                                text: adminPostData['Title'].toString(),
                              ),
                            ); // Return an empty widget or null if data is incomplete
                          }),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
