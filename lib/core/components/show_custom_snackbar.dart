import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    if (!isError) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: isError ? Colors.red.shade400 : Colors.green,
          message: message,
          duration: const Duration(seconds: 3),
          snackStyle: SnackStyle.FLOATING,
          margin: EdgeInsets.all(10.sp),
          borderRadius: 8.r,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          margin: EdgeInsets.only(
            right: 10.h,
            top: 10.h,
            bottom: 10.h,
            left: 10.h,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: isError ? Colors.red.shade400 : Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }
}
