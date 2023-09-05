// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/post_texfield.dart';
import '../../widget/custom_bootombar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_post.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'logic.dart';

class MediaWall extends StatefulWidget {
  const MediaWall({super.key});

  @override
  State<MediaWall> createState() => _MediaWallState();
}

class _MediaWallState extends State<MediaWall> {
  final MediaWallLogic controller = Get.put(MediaWallLogic());
  final Rx<TextEditingController> titleController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance.collection('MediaWall');
  final RxBool loading = false.obs;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('MediaWall');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.customThemeColor,
        title: Text(
          'Compose',
          style: controller.state.value.appbartextTextStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
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
                    textEditingController: titleController.value,
                    maxLength: 1,
                    validate: (value) => {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Select Image*',
                        style: controller.state.value.posttextTextstyle,
                      ),
                    ],
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
                    padding: EdgeInsets.only(top: 20.h),
                    child: CustomButton(
                      borderRadius: 8.r,
                      label: loading.value
                          ? ''
                          : 'Upload', // Hide the label when loading
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
                                .ref('mediawall/');
                            firebase_storage.UploadTask uploadTask =
                                ref.putFile(logic.image!.absolute);
                            await uploadTask.whenComplete(() => null);

                            // Get the download URL of the uploaded image
                            String imageUrl = await ref.getDownloadURL();

                            // Save data including image URL in Firestore
                            await firestore.doc().set({
                              'Title': titleController.value.text,
                              'Imageurl': imageUrl,
                              'id': auth.currentUser!.uid,
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
                            titleController.value.clear();
                            controller.clearImage();
                          } catch (error) {
                            // Show an error message
                            if (kDebugMode) {
                              print(error);
                            }
                            Get.snackbar('Post Failed', error.toString(),
                                colorText: AppColors.customScaffoldColor,
                                backgroundColor: Colors.redAccent,
                                borderRadius: 11.r,
                                icon: const Icon(
                                  Icons.error_outline,
                                  color: AppColors.customScaffoldColor,
                                ));
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
                          :null, // Hide the indicator when not loading
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
