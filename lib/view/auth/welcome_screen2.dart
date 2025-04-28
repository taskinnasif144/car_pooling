import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/constant/app_assets.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/view/auth/explore_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.welcomeToHadikid ,
                style: AppStyle.headerBold1.copyWith(fontSize: 40.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                AppLocalizations.of(context)!.letSGetYouStarted,
                style: AppStyle.baseRegular.copyWith(
                  color: AppColors.darkGray,
                  fontSize: 32.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 200,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(AppAssets.logoPng),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.getStartedByInvitingFriendsToJoinYourCarpool ,
                style: AppStyle.baseRegular.copyWith(
                  color: AppColors.darkGray,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                buttonTitle: AppLocalizations.of(context)!.createCarpool ,
                onTap: () {
                  Get.toNamed(AppRoutes.createCarpool1);
                },
              ),
                 SizedBox(height: 24.h),
              CustomButton(
                buttonTitle: "Explore the App!" ,
                isFilled: false,
                onTap: () {
                  Get.to(()=> ExploreAppScreen());
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
