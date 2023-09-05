import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raah_e_roshan/src/modules/create_post/logic.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/custom_bootombar.dart';
import 'package:raah_e_roshan/src/widget/custom_button.dart';
import 'package:raah_e_roshan/src/widget/custom_post.dart';
import 'package:raah_e_roshan/src/widget/post_texfield.dart';

class AdminCreatePost extends StatefulWidget {
  const AdminCreatePost({super.key});

  @override
  State<AdminCreatePost> createState() => _AdminCreatePostState();
}

class _AdminCreatePostState extends State<AdminCreatePost> {
  final CreatePostLogic controller = Get.put(CreatePostLogic());
  final Rx<TextEditingController> adminPostTitleController =
      TextEditingController().obs;
  final Rx<TextEditingController> adminPostDiscriptionController =
      TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
  final adminfirestore = FirebaseFirestore.instance.collection('admin');
  final RxBool loading = false.obs;
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  // DatabaseReference adminDataBaseRef = FirebaseDatabase.instance.ref('admin');

// ...
  @override
  void initState() {
    super.initState();
    logic.requestNotificationPermission();
    logic.forgroundMessage();
    logic.firebaseInit(context);
    logic.setupInteractMessage(context);
    logic.isTokenRefresh();

    logic.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.customThemeColor,
          title: Text(
            'Compose',
            style: controller.state.value.buttontextTextStyle,
          ),
          leading: const Icon(null)),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Add the title*',
                        style: controller.state.value.posttextTextstyle,
                      ),
                    ],
                  ),
                  PostTextField(
                    helperText: 'Enter Your Title',
                    textEditingController: adminPostTitleController.value,
                    maxLength: 1,
                    validate: (value) => {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Add the Discription*',
                        style: controller.state.value.posttextTextstyle,
                      ),
                    ],
                  ),
                  PostTextField(
                    helperText: 'Enter Your Title',
                    textEditingController: adminPostDiscriptionController.value,
                    maxLength: 1,
                    validate: (value) => {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Row(
                      children: [
                        Text(
                          'Select Image*',
                          style: controller.state.value.posttextTextstyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.getImageGallery();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.photo_album_outlined,
                                color: AppColors.customThemeColor,
                              ),
                              Text(
                                'Image Form Gallery',
                                style: controller.state.value.posttextTextstyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: CustomButton(
                      borderRadius: 8.r,
                      label: loading.value
                          ? ''
                          : 'Submit', // Hide the label when loading
                      backgroundColor: AppColors.customThemeColor,
                      onTap: () async {
                        if (!loading.value) {
                          // Set loading state
                          setState(() {
                            loading.value = true;
                          });

                          try {
                            // Upload image to Firebase Storage
                            firebase_storage.Reference ref = firebase_storage
                                .FirebaseStorage.instance
                                .ref('AdminPostImage/');
                            firebase_storage.UploadTask uploadTask =
                                ref.putFile(logic.image!.absolute);
                            await uploadTask.whenComplete(() => null);

                            // Get the download URL of the uploaded image
                            String imageUrl = await ref.getDownloadURL();

                            // Save data including image URL in Firestore
                            await adminfirestore.doc().set({
                              'Title': adminPostTitleController.value.text,
                              'Discription':
                                  adminPostDiscriptionController.value.text,
                              'Imageurl': imageUrl,
                            });

                            // Send notification
                            logic.getDeviceToken().then((value) async {
                              var data = {
                                'to': value.toString(),
                                'notification': {
                                  'title': 'Raah e Roshan',
                                  'body': 'You received a new notification',
                                  "sound": "jetsons_doorbell.mp3"
                                },
                                'android': {
                                  'notification': {
                                    'notification_count': 23,
                                  },
                                },
                                'data': {'type': 'post', 'id': 'raah e roshan'}
                              };

                              await http.post(
                                  Uri.parse(
                                      'https://fcm.googleapis.com/fcm/send'),
                                  body: jsonEncode(data),
                                  headers: {
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                    'Authorization':
                                        'key=AAAAWD5TN6Y:APA91bFpf8_FmP08ZsBeWC2JWRJMm_0vuGvMGAPaM5VkJqqjqLW4uHTVKK3-gpV0LU8Bu9AkFeG4D8YAB4_dzhHYXamxDfHmwAW0VmMPtLVFd3zpLxmoDfwxwVop7m63-R38hzMPHdSi'
                                  }).then((value) {
                                if (kDebugMode) {
                                  print(value.body.toString());
                                }
                              }).onError((error, stackTrace) {
                                if (kDebugMode) {
                                  print(error);
                                }
                              });
                            });

                            // Show a success dialog using awesome_dialog
                            // ignore: use_build_context_synchronously
                            await AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.leftSlide,
                              title: 'Success',
                              desc: 'Data uploaded successfully.',
                              btnOkText: 'OK',
                              btnOkOnPress: () {
                                Navigator.of(context).pop();
                                Get.to(const CustomBottomBar());
                              },
                            ).show();

                            // Clear input fields
                            adminPostTitleController.value.clear();
                            controller.clearImage();
                          } catch (error) {
                            // Show an error message
                            if (kDebugMode) {
                              print(error.toString());
                            }
                          } finally {
                            // Reset loading state
                            setState(() {
                              loading.value = false;
                            });
                          }
                        }
                      },
                      labelStyle: TextStyle(
                        color: AppColors.customScaffoldColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      child: loading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.customScaffoldColor,
                              ),
                            )
                          : null, // Hide the indicator when not loading
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
