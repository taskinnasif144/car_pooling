import 'package:car_pooling/controller/auth_controller.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/custom_input_field.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1("Create New Password".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24.h,
                children: [
                  Text(
                    "Create new password here".tr,
                    style: AppStyle.baseRegular.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                  CustomInputField(
                    controller: controller.newPassController,
                    title: "New password".tr,
                  ),
                  CustomInputField(
                    controller: controller.confirmNewPassController,
                    title: "Confirm new password".tr,
                  ),
                ],
              ),

              Obx(() {
                return CustomButton(
                  buttonTitle: "Done".tr,
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    controller.createNewpass();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
