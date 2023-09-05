import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/post_details/view.dart';
import '../../utils/colors.dart';
import '../../widget/custom_post.dart';
import 'logic.dart';

class AllPost extends StatefulWidget {
  const AllPost({super.key});

  @override
  State<AllPost> createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  final logic = Get.put(AllPostLogic());
  final state = Get.find<AllPostLogic>().state;
  final AllPostLogic piccountroller = Get.put(AllPostLogic());
  // final firestore = FirebaseFirestore.instance.collection('user').snapshots();
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.customThemeColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.customThemeColor,
        // leading: const Icon(null),
        title: Text(
          'Posts',
          style: state.textTextstyle,
        ),
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
                            DocumentSnapshot image = snapshot.data!.docs[index];
                            return Padding(
                              padding: EdgeInsets.all(8.0.h),
                              child: InkWell(
                                onTap: () async {
                                  DocumentSnapshot postSnapshot =
                                      snapshot.data!.docs[index];
                                  Map<String, dynamic> postData = postSnapshot
                                      .data() as Map<String, dynamic>;

                                  // Show the PostDetails page
                                  await Get.to(PostDetails(
                                    imageUrl: postData['Imageurl'],
                                    discription: postData['Title'],
                                    donationtype: postData['DonationType'],
                                    address: postData['Address'],
                                    quantity: postData['Quantity'],
                                    donorname: postData['Name'],
                                    phonenumber: postData['PhoneNumber'],
                                    onPressed: () async {
                                      // Move the post to the "AcceptedPosts" collection
                                      await FirebaseFirestore.instance
                                          .collection('RejectedPosts')
                                          .doc(postSnapshot.id)
                                          .set(postData);

                                      // Delete the post from the main post collection
                                      await FirebaseFirestore.instance
                                          .collection('UserPost')
                                          .doc(postSnapshot.id)
                                          .delete();

                                      // Navigate back to the list of posts
                                      Get.back();
                                    },
                                    onTap: () async {
                                      if (kDebugMode) {
                                        print('Accept button tapped');
                                      }
                                      // Move the post to the "RejectedPosts" collection
                                      await FirebaseFirestore.instance
                                          .collection('AcceptedPosts')
                                          .doc(postSnapshot.id)
                                          .set(postData);

                                      // Delete the post from the main post collection
                                      await FirebaseFirestore.instance
                                          .collection('UserPost')
                                          .doc(postSnapshot.id)
                                          .delete();

                                      // Navigate back to the list of posts
                                      Get.back();
                                    },
                                  ));
                                },
                                child: CustomPosts(
                                  text: image['Title'],
                                  image: image['Imageurl'],
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
// child: InkWell(
                              //   onTap: () => {
                              //     Get.to(PostDetails(
                              //       imageUrl: image['Imageurl'],
                              //       discription: image['Title'],
                              //       donationtype: image['DonationType'],
                              //       address: image['Address'],
                              //       quantity: image['Quantity'],
                              //       donorname: image['Name'],
                              //       // phonenumber: image['PhoneNumber'],
                              //       ontap: () async {
                              //         DocumentSnapshot imageSnapshot =
                              //             snapshot.data!.docs[index];
                              //         Map<String, dynamic> imageData =
                              //             imageSnapshot.data()
                              //                 as Map<String, dynamic>;

                              //         // Update the document in the accepted collection
                              //         await FirebaseFirestore.instance
                              //             .collection('AcceptedPosts')
                              //             .doc(imageSnapshot.id)
                              //             .set(imageData);

                              //         // Delete the document from the main post collection
                              //         await FirebaseFirestore.instance
                              //             .collection('UserPost')
                              //             .doc(imageSnapshot.id)
                              //             .delete();
                              //       },
                              //     ))
                              //   },
                              //   child: CustomPosts(
                              //     text: image['Title'],
                              //     image: image['Imageurl'],
                              //   ),
                              // ),