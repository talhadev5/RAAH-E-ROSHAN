import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/create_post/logic.dart';
import '../utils/colors.dart';

class CustomPosts extends StatefulWidget {
  final String text;
  final String image;
  const CustomPosts({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  State<CustomPosts> createState() => _CustomPostsState();
}

final logic = Get.put(CreatePostLogic());
final state = Get.find<CreatePostLogic>().state;
final auth = FirebaseAuth.instance;
@override
void initState() => initState();

class _CustomPostsState extends State<CustomPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 240.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: const [
            BoxShadow(
                color: AppColors.customShadowColor,
                offset: Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 0)
          ],
          color: AppColors.customScaffoldColor),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
            child: SizedBox(
                height: 135.h,
                width: double.infinity,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                )),
          ),
          // discription
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Text(widget.text),
          ),

          SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }
}
