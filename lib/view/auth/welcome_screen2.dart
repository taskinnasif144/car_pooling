import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/constant/app_assets.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to HadiKid🎉",
                style: AppStyle.headerBold1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Text(
                "Let’s get you started. No carpools yet! Get started by creating a carpool and sending invite.",
                style: AppStyle.baseRegular.copyWith(color: AppColors.darkGray),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              Image.asset(AppAssets.appLogo),
              SizedBox(height: 48.h),
              CustomButton(buttonTitle: "Create Carpool", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
