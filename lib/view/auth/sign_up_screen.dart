import 'package:car_pooling/controller/auth_controller.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/custom_input_field.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          // The list view is used to shift the layout at the bottom and enable scrolling behaviour
          child: ListView(
            // reverse is used to shift the layout at the bottom
            reverse: false,
            children: [
              // Extra column taken, so that we dont have to lay the widgets in oppostite order
              Column(
                children: [
                  SizedBox(height: 48.h),
                  Text(
                    "Let’s set up an account".tr,
                    style: AppStyle.headerBold2,
                  ),
                  SizedBox(height: 24.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // =================>>>>>>>>>>>>> Text Controller <<<<<<<<<<<<<===============
                        CustomInputField(
                          controller: controller.firstNameController,
                          hintText: "First Name".tr,
                        ),
                        SizedBox(height: 16.h),
                        CustomInputField(
                          controller: controller.lastNameController,
                          hintText: "Last Name".tr,
                        ),
                        SizedBox(height: 16.h),
                        CustomInputField(
                          controller: controller.emailController,
                          hintText: "Email".tr,
                        ),
                        SizedBox(height: 16.h),
                        CustomInputField(
                          controller: controller.passwordController,
                          hintText: "Password".tr,
                          isPassword: true,
                        ),
                        SizedBox(height: 12.h),
                        // =================>>>>>>>>>>>>> Terms & Conditions <<<<<<<<<<<<<===============
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4.w,
                          children: [
                            Obx(() {
                              return Checkbox(
                                value: controller.checkBoxStatus.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.checkBoxStatus.value = value;
                                  }
                                },
                              );
                            }),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: "I agree to HadiKid's ",
                                  style: AppStyle.baseSmallMedium.copyWith(
                                    color: AppColors.gray,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: AppStyle.baseSmallMedium.copyWith(
                                        color: AppColors.primary.withOpacity(
                                          0.8,
                                        ),
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              launchUrl(
                                                Uri.parse(
                                                  'https://hadikid.com/hizmet-sartlari.html',
                                                ),
                                              );
                                            },
                                    ),
                                    TextSpan(text: " and "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: AppStyle.baseSmallMedium.copyWith(
                                        color: AppColors.primary.withOpacity(
                                          0.8,
                                        ),
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              launchUrl(
                                                Uri.parse(
                                                  'https://hadikid.com/gizlilik-politikasi.html',
                                                ),
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // =================>>>>>>>>>>>>> SignUpButton <<<<<<<<<<<<<===============
                        Obx(() {
                          return CustomButton(
                            buttonTitle: "Sign Up".tr,
                            onTap: () {
                              controller.userSignUp(_formKey);
                            },
                            isLoading: controller.isLoading.value,
                          );
                        }),
                        SizedBox(height: 32.h),
                        // =================>>>>>>>>>>>>> goto sign up <<<<<<<<<<<<<===============
                        Row(
                          spacing: 4.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?".tr,
                              style: AppStyle.smallRegular.copyWith(
                                color: AppColors.gray,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.signIn);
                              },
                              child: Text(
                                "Sign In".tr,
                                style: AppStyle.smallMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
