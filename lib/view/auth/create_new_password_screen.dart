import 'package:car_pooling/controller/auth_controller.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/custom_input_field.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(AppLocalizations.of(context)!.createNewPassword),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
          child: Column(
            children: [
              SizedBox(),
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 24.h,
                  children: [
                    CustomInputField(
                      controller: controller.newPassController,
                      title: "New password",
                      isPassword: true,
                    ),
                    CustomInputField(
                      controller: controller.confirmNewPassController,
                      title: "Retype new password",
                      isPassword: true,
                    ),
                    SizedBox(height: 24.h),

                    Obx(() {
                      return CustomButton(
                        buttonTitle: AppLocalizations.of(context)!.done,
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          controller.createNewpass(_formkey);
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
