import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/admin_create_post/view.dart';
import 'package:raah_e_roshan/src/modules/available_donation/view.dart';
import 'package:raah_e_roshan/src/modules/create_post/view.dart';
import 'package:raah_e_roshan/src/modules/dashboard/view.dart';
import 'package:raah_e_roshan/src/modules/user_profile/view.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

import 'custom_post.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Widget> _pages = [
    DashBoard(),
    auth.currentUser!.phoneNumber == '+923411827155'
        ? const AdminCreatePost()
        : const CreatePost(),
    UserProfile(),
  ];
  // Function to open the bottom sheet
  void _openPostBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height * .2,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Get.to(const AvailableDonation());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90.w),
                  child: InkWell(
                    onTap: () => {Get.to(const AvailableDonation())},
                    child: Container(
                      height: Get.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                              style: BorderStyle.solid,
                              width: 1,
                              color: AppColors.customThemeColor)),
                      child: const Center(
                          child: Text(
                        'Donate Cash',
                        style: TextStyle(color: AppColors.customBlackColor),
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextButton(
                onPressed: () {
                  Get.to(const CreatePost());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90.w),
                  child: InkWell(
                    onTap: () => {Get.to(const CreatePost())},
                    child: Container(
                      height: Get.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                              style: BorderStyle.solid,
                              width: 1,
                              color: AppColors.customThemeColor)),
                      child: const Center(
                          child: Text(
                        'Other',
                        style: TextStyle(color: AppColors.customBlackColor),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const Drawer(),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.h,
        key: _bottomNavigationKey,
        color: AppColors.customThemeColor,
        animationCurve: Curves.ease,
        backgroundColor: AppColors.customScaffoldColor,
        items: [
          const CurvedNavigationBarItem(
            child:
                Icon(Icons.home_outlined, color: AppColors.customScaffoldColor),
            labelStyle: TextStyle(
              color: AppColors.customScaffoldColor,
            ),
            label: 'Home',
          ),
          auth.currentUser!.phoneNumber == '+923411827155'
              ? const CurvedNavigationBarItem(
                  child: Icon(Icons.add, color: AppColors.customScaffoldColor),
                  label: 'Post',
                  labelStyle: TextStyle(
                    color: AppColors.customScaffoldColor,
                  ),
                )
              : CurvedNavigationBarItem(
                  child: IconButton(
                      onPressed: () => {_openPostBottomSheet()},
                      icon: const Icon(Icons.edit_outlined),
                      color: AppColors.customScaffoldColor),
                  label: 'Post',
                  labelStyle: const TextStyle(
                    color: AppColors.customScaffoldColor,
                  ),
                ),
          const CurvedNavigationBarItem(
            child:
                Icon(Icons.perm_identity, color: AppColors.customScaffoldColor),
            label: 'Profile',
            labelStyle: TextStyle(
              color: AppColors.customScaffoldColor,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: IndexedStack(
        index: _page,
        children: _pages,
      ),
    );
  }
}
