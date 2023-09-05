import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/All_post/view.dart';
import 'package:raah_e_roshan/src/modules/notification_page/logic.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final logic = Get.put(NotificationPageLogic());

  final state = Get.find<NotificationPageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.customThemeColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Notification'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(children: [
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('UserPost').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.customThemeColor,
              ));
            }
            if (snapshot.hasError) return const Center(child: Text('Error'));

            return Expanded(
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show indicator when waiting
                  : snapshot.hasError
                      ? const Center(
                          child: Text(
                              'Connection Error')) // Show error message if error occurred
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot data = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => {Get.to(const AllPost())},
                                child: Container(
                                  // height: Get.height * 0.2,
                                  // width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColors.customScaffoldColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.customGreyColor1,
                                            offset: const Offset(0, 0),
                                            blurRadius: 1.r,
                                            spreadRadius: 0)
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 11.w, vertical: 10.r),
                                    child: Center(child: Text(data['Title'])),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            );
          },
        )
      ]),
    );
  }
}
