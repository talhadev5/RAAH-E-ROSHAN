import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/donation_history/logic.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_post.dart';

class DonationHistory extends StatelessWidget {
  DonationHistory({super.key});
  final logic = Get.put(DonationHistoryLogic());
  final state = Get.find<DonationHistoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.customThemeColor,
          elevation: 1,
          centerTitle: true,
          title: const Text('History'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Total Donation ///
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        height: Get.height * .09,
                        width: Get.width * .4,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: AppColors.customShadowColor,
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  spreadRadius: 0)
                            ],
                            color: AppColors.customScaffoldColor,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Donation',
                              style: state.titletextTextstyle,
                            ),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('AcceptedPosts')
                                  .where('id', isEqualTo: auth.currentUser!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.customThemeColor,
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Center(child: Text('Error'));
                                }

                                // Calculate the total number of accepted posts
                                int totalAcceptedPosts =
                                    snapshot.data?.docs.length ?? 0;

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' $totalAcceptedPosts',
                                    style: state.textTextstyle,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    // Pending Donation //
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Container(
                        height: Get.height * .09,
                        width: Get.width * .4,
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //   style: BorderStyle.solid,
                            //   color: AppColors.customThemeColor,
                            // ),
                            boxShadow: const [
                              BoxShadow(
                                  color: AppColors.customShadowColor,
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  spreadRadius: 0)
                            ],
                            color: AppColors.customScaffoldColor,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pending Dontion',
                              style: state.titletextTextstyle,
                            ),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('UserPost')
                                  .where('id', isEqualTo: auth.currentUser!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.customThemeColor,
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Center(child: Text('Error'));
                                }

                                // Calculate the total number of accepted posts
                                int totalAcceptedPosts =
                                    snapshot.data?.docs.length ?? 0;

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' $totalAcceptedPosts',
                                    style: state.textTextstyle,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Reject Post ///
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Container(
                  height: Get.height * .09,
                  width: Get.width * .4,
                  decoration: BoxDecoration(
                      // border: Border.all(
                      //   style: BorderStyle.solid,
                      //   color: AppColors.customThemeColor,
                      // ),
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.customShadowColor,
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 0)
                      ],
                      color: AppColors.customScaffoldColor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rejected Dontion',
                        style: state.titletextTextstyle,
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('RejectedPosts')
                            .where('id', isEqualTo: auth.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.customThemeColor,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(child: Text('Error'));
                          }

                          // Calculate the total number of accepted posts
                          int totalAcceptedPosts =
                              snapshot.data?.docs.length ?? 0;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ' $totalAcceptedPosts',
                              style: state.textTextstyle,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
