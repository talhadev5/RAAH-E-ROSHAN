// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';
import 'package:raah_e_roshan/src/widget/post_texfield.dart';
import '../../widget/custom_bootombar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_meal_container.dart';
import '../../widget/custom_post.dart';
import 'logic.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final CreatePostLogic controller = Get.put(CreatePostLogic());
  final Rx<TextEditingController> quntitieController =
      TextEditingController().obs;
  final Rx<TextEditingController> addressController =
      TextEditingController().obs;
  final Rx<TextEditingController> titleController = TextEditingController().obs;
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> phonenumberController =
      TextEditingController().obs;
  final selectedMealTimings = <String>[].obs;
  final formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance.collection('UserPost');
  final RxBool loading = false.obs;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('UserPost');

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

  void updateAddressField() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: 'en', // Set your preferred locale
    );

    if (placemarks.isNotEmpty) {
      Placemark firstPlacemark = placemarks.first;

      String plotName = firstPlacemark.name ?? ''; // Nearby road or street name
      String subLocality =
          firstPlacemark.subLocality ?? ''; // Neighborhood or sub-locality
      String locality = firstPlacemark.locality ?? ''; // City or locality

      String selectedAddress = '$plotName, $subLocality, $locality';

      setState(() {
        addressController.value.text = selectedAddress;
      });
    } else {
      setState(() {
        addressController.value.text = ''; // Set text to empty if no placemarks
      });
    }
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Donation Type*',
                            style: controller.state.value.posttextTextstyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      /// ........meal timing.....///
                      Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        spacing: 10,
                        children: List.generate(
                          logic.donationtype.length,
                          (index) => MealContainer(
                            text: logic.donationtype[index],
                            isSelected: logic
                                .isSelectedDonation(logic.donationtype[index]),
                            onTap: () {
                              setState(() {
                                logic.setSelectedDonationType(
                                    logic.donationtype[index]);
                              });
                              // logic.selectMeal(logic.mealtiminglist[index]);
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter Address*',
                            style: controller.state.value.posttextTextstyle,
                          ),
                          TextButton(
                            onPressed: () {
                              // Call a function to fetch the current location and update the address field
                              updateAddressField();
                            },
                            child: Text('Current Location',
                                style: state.value.textTextStyle),
                          ),
                        ],
                      ),
                      PostTextField(
                        textEditingController: addressController.value,
                        helperText: '@e.g Medina Town Faislabad',
                        maxLength: 1,
                        validate: (p0) => {},
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Enter Quantity*',
                            style: controller.state.value.posttextTextstyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      PostTextField(
                        textEditingController: quntitieController.value,
                        helperText: '@e.g 123',
                        maxLength: 1,
                        validate: (p0) => {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enter Your Name*',
                        style: controller.state.value.posttextTextstyle,
                      ),
                      Text(
                        'Enter Phone Number*',
                        style: controller.state.value.posttextTextstyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PostTextField(
                          helperText: 'Enter Name',
                          textEditingController: nameController.value,
                          maxLength: 1,
                          validate: (value) => {},
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: PostTextField(
                            textInputType: TextInputType.phone,
                            helperText: 'Phone Number',
                            textEditingController: phonenumberController.value,
                            maxLength: 1,
                            validate: (value) => {},
                          ),
                        ),
                      ),
                    ],
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
                                'Image From Gallery',
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
                                .ref('UserPostImages/');
                            firebase_storage.UploadTask uploadTask =
                                ref.putFile(logic.image!.absolute);
                            await uploadTask.whenComplete(() => null);

                            // Get the download URL of the uploaded image
                            String imageUrl = await ref.getDownloadURL();

                            // Save data including image URL in Firestore
                            await firestore.doc(auth.currentUser!.uid).set({
                              'Title': titleController.value.text,
                              'Address': addressController.value.text,
                              'Quantity': quntitieController.value.text,
                              'Imageurl': imageUrl,
                              'DonationType': logic.getSelectedDonationType(),
                              'id': auth.currentUser!.uid,
                              'Name': nameController.value.text,
                              'PhoneNumber': phonenumberController.value.text
                            });

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
                            titleController.value.clear();
                            addressController.value.clear();
                            quntitieController.value.clear();
                            phonenumberController.value.clear();
                            nameController.value.clear();
                            controller.clearImage();
                            logic.clearSelectedDonationType();
                          } catch (error) {
                            // Show an error message

                            Get.snackbar('Post Failed', '',
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
