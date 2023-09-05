import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../modules/payment_method/logic.dart';
import '../utils/colors.dart';

class Pyamentcrad extends StatelessWidget {
  final String title;
  final String accountnumber;
  final String accountowner;

  final String image;
  Pyamentcrad(
      {super.key,
      required this.title,
      required this.accountnumber,
      required this.accountowner,
      required this.image});
  final logic = Get.put(PaymentmethodLogic());
  final state = Get.find<PaymentmethodLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              height: 40.h,
              width: 40.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(image),
            ),
            title: Text(
              title,
              style: state.textTextstyle,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  accountowner,
                  style: state.textTextstyle,
                ),
                Text(accountnumber, style: state.accountnumberTextstyle),
                SizedBox(height: 2.h), // Add spacing

                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                      text: accountnumber,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account number copied')),
                    );
                  },
                  child: Container(
                    height: Get.height * 0.025,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          style: BorderStyle.solid,
                          width: 1,
                          color: AppColors.customGreyColor,
                        )),
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: const Text(
                      'Copy',
                      style: TextStyle(
                        color: AppColors.customThemeColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
