import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/available_donation/logic.dart';
import 'package:raah_e_roshan/src/modules/donation_details/view.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_donating_things.dart';

class AvailableDonation extends StatefulWidget {
  const AvailableDonation({super.key});

  @override
  State<AvailableDonation> createState() => _AvailableDonationState();
}

class _AvailableDonationState extends State<AvailableDonation> {
  final logic = Get.put(AvailableDonationLogic());

  final state = Get.find<AvailableDonationLogic>().state;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.customScaffoldColor,
        iconTheme: const IconThemeData(color: AppColors.customThemeColor),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            'Choose where to donate',
            style: state.titleTextstyle,
          )),
          SizedBox(
            height: 10.h,
          ),
          // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          //   stream: FirebaseFirestore.instance.collection('admin').snapshots(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }

          //     if (snapshot.hasError) {
          //       return const Text('Error occurred');
          //     }

          //     if (snapshot.data!.docs.isEmpty) {
          //       return const Text('No data');
          //     }

          //     return Expanded(
          //       child: ListView.builder(
          //           itemCount: snapshot.data!.docs.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             DocumentSnapshot adminPostData =
          //                 snapshot.data!.docs[index];

          //             // Ensure the required fields exist before accessing them

          //             return Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: auth.currentUser!.phoneNumber ==
          //                         '+923411827155'
          //                     ? Dismissible(
          //                         key: Key(adminPostData
          //                             .id), // Use a unique identifier here
          //                         onDismissed: (direction) async {
          //                           // Handle deletion here
          //                           await FirebaseFirestore.instance
          //                               .collection('admin')
          //                               .doc(adminPostData.id)
          //                               .delete();
          //                         },
          //                         background: Container(
          //                           color: AppColors.customGreyColor,
          //                           alignment: Alignment.centerRight,
          //                           padding: const EdgeInsets.only(right: 16),
          //                           child: const Icon(Icons.delete,
          //                               color: Colors.red),
          //                         ),
          //                         child: CustomDonateThings(
          //                           onTap: () {
          //                             Get.to(DonationDetails(
          //                               image: adminPostData['Imageurl'],
          //                               titletext: adminPostData['Title'],
          //                               discriptiontext:
          //                                   adminPostData['Discription'],
          //                             ));
          //                           },
          //                           image: adminPostData['Imageurl'].toString(),
          //                           text: adminPostData['Title'].toString(),
          //                         ))
          //                     : CustomDonateThings(
          //                         onTap: () {
          //                           Get.to(DonationDetails(
          //                             image: adminPostData['Imageurl'],
          //                             titletext: adminPostData['Title'],
          //                             discriptiontext:
          //                                 adminPostData['Discription'],
          //                           ));
          //                         },
          //                         image: adminPostData['Imageurl'].toString(),
          //                         text: adminPostData['Title'].toString(),
          //                       )); // Return an empty widget or null if data is incomplete
          //           }),
          //     );
          //   },
          // ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('admin').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Text('Error occurred');
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Text('No data');
              }

              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot adminPostData =
                          snapshot.data!.docs[index];

                      // Ensure the required fields exist before accessing them

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: Key(
                              adminPostData.id), // Use a unique identifier here
                          onDismissed: (direction) async {
                            // Handle deletion here
                            await FirebaseFirestore.instance
                                .collection('admin')
                                .doc(adminPostData.id)
                                .delete();
                          },
                          background: Container(
                            color: AppColors.customGreyColor,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16),
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                          child: CustomDonateThings(
                            onTap: () {
                              Get.to(DonationDetails(
                                image: adminPostData['Imageurl'],
                                titletext: adminPostData['Title'],
                                discriptiontext: adminPostData['Discription'],
                              ));
                            },
                            image: adminPostData['Imageurl'].toString(),
                            text: adminPostData['Title'].toString(),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
