import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

AlertDialog customAlertDialog({
  title,
  content,
  asset,
  buttonText = "OK",
  route,
  isConfirm = false,

  isDelete = false,
}) {
  return AlertDialog(
    icon:
        asset != null
            ? Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: SvgPicture.asset(asset),
            )
            : null,
    title: Text(
      title,
      style: AppStyle.headerRegular3.copyWith(color: AppColors.primary),
    ),
    content: Text(
      content,
      style: AppStyle.baseRegular.copyWith(color: AppColors.darkGray),
      
    ),
    actions: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isConfirm)
            SizedBox(
              width: Get.width / 3.3,
              child: CustomButton(
                buttonTitle: "Cancel" ,
                isFilled: false,

                onTap: () {
                  Get.back();
                },
              ),
            ),
          SizedBox(
            width: Get.width / 3.3,
            child: CustomButton(
              buttonTitle: buttonText,
              isFilled: true,
              isRed: isDelete,
              onTap: () {
                route();
              },
            ),
          ),
        ],
      ),
    ],
  );
}
