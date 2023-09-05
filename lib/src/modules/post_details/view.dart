// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raah_e_roshan/src/modules/post_details/logic.dart';
import 'package:raah_e_roshan/src/utils/colors.dart';

class PostDetails extends StatefulWidget {
  final String imageUrl;
  final Function? onPressed;
  final Function? onTap;

  final String discription;
  final String donorname;
  final String phonenumber;
  final String quantity;
  final String address;
  final String donationtype;
  const PostDetails({
    super.key,
    required this.address,
    required this.imageUrl,
    required this.discription,
    required this.quantity,
    required this.donationtype,
    required this.donorname,
    this.onPressed,
    this.onTap, required this.phonenumber,

    // required this.phonenumber,
    //  required this.phonenumber,
  });

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final logic = Get.put(PostDetialsLogic());
  final state = Get.find<PostDetialsLogic>().state;
  final PostDetialsLogic picCountroller = Get.put(PostDetialsLogic());
  bool loading = false;

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: Get.height * .35,
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              )),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Discription',
                    style: state.value.titleTextstyle,
                  ),
                  subtitle: Text(
                    widget.discription,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Donation Type',
                    style: state.value.titleTextstyle,
                  ),
                  subtitle: Text(
                    widget.donationtype,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Quantity',
                    style: state.value.titleTextstyle,
                  ),
                  subtitle: Text(
                    widget.quantity,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Address',
                    style: state.value.titleTextstyle,
                  ),
                  subtitle: Text(
                    widget.address,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Donor Name',
                    style: state.value.titleTextstyle,
                  ),
                  subtitle: Text(
                    widget.donorname,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Phone Number',
                    style: state.value.titleTextstyle,
                  ),
                  subtitle: Text(
                    widget.phonenumber
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => widget.onPressed!(),
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                            color: AppColors.customThemeColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Center(
                                child: Text('Reject',
                                    style: state.value.textTextstyle)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => widget.onTap!(),
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                            color: AppColors.customThemeColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Center(
                                child: Text('Accept',
                                    style: state.value.textTextstyle)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //
        ],
      ),
    );
  }
}
   // onTap: () => {OnTap
                        // AwesomeDialog(
                        //   context: context,
                        //   dialogType: DialogType.success,
                        //   animType: AnimType.bottomSlide,
                        //   title: 'Accept',
                        //   desc: ' Finally donation are accepted',
                        //   btnOkOnPress: () async {},
                        //   btnOkColor: AppColors.customThemeColor,
                        //   buttonsBorderRadius: BorderRadius.circular(8.r),
                        // ).show()
                        // },