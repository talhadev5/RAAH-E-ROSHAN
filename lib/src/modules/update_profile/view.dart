import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/update_profile/logic.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_textfield.dart';
import '../../widget/custom_button.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final RxBool loading = false.obs;
  final logic = Get.put(UpdateProfileLogic());

  final state = Get.find<UpdateProfileLogic>().state;
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController donortypecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users');

  // DatabaseReference databaseRef =
  //     FirebaseDatabase.instance.ref().child('users');
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // usernamecontroller.text = '' ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.customThemeColor,
        title: Text(
          'Update Profile',
          style: state.appbartextTextStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 35.h,
            ),
            Center(
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
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
            TextButton(
                onPressed: () => {
                      logic.uploadImage(),
                    },
                child: Text(
                  'Change Photo',
                  style: state.textbuttonTextStyle,
                )),
            SizedBox(height: 20.h),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
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

                  // Create TextEditingController instances to manage the text field values
                  TextEditingController usernameController =
                      TextEditingController(text: userData['username']);
                  TextEditingController donorTypeController =
                      TextEditingController(text: userData['donorType']);
                  TextEditingController phoneNumberController =
                      TextEditingController(text: userData['phone number']);

                  return Column(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CustomTextField(
                        textEditingController: usernameController,
                        onChanged: (value) {
                          setState(() {
                            userData['username'] = value;
                          });
                        },
                        helperText: 'Enter Your Name',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CustomTextField(
                        textEditingController: donorTypeController,
                        onChanged: (value) {
                          setState(() {
                            userData['donorType'] = value;
                          });
                        },
                        helperText: 'Donor Type',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CustomTextField(
                        textEditingController: phoneNumberController,
                        onChanged: (value) {
                          setState(() {
                            userData['phone number'] = value;
                          });
                        },
                        helperText: 'Phone Number',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 40.h, left: 8.w, right: 8.w),
                      child: CustomButton(
                        borderRadius: 8.r,
                        label: 'Update',
                        backgroundColor: AppColors.customThemeColor,
                        onTap: () {
                          // Update the user data in Firestore when the button is pressed
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(auth.currentUser!.uid)
                              .update(userData);
                        },
                        labelStyle: TextStyle(
                          color: AppColors.customScaffoldColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]);
                }),
          ],
        ),
      ),
    );
  }
}
