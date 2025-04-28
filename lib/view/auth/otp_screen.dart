import 'package:car_pooling/controller/auth_controller.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    super.key,
    required this.isReset,
    required this.sendTo,
    required this.isPhone,
  });
  final bool isReset;
  final bool isPhone;
  // This variable only shows which number/email the otp has been sent to
  final String sendTo;

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(
        isReset
            ? AppLocalizations.of(context)!.resetPassword
            : AppLocalizations.of(context)!.verification,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: ListView(
            reverse: false,
            children: [
              SizedBox(height: 94.h),
              Column(
                children: [
                  Text(
                    !isPhone
                        ? "${AppLocalizations.of(context)!.anOtpCodeHasBeenSentTo} $sendTo ${AppLocalizations.of(context)!.toResetPasswordIfYouDonTSeeItInYourInboxPleaseCheckYourJunkOrSpamFolderEnterTheCodeBelowToContinue}"
                        : "${AppLocalizations.of(context)!.anOtpCodeHasBeenSentTo} $sendTo ${AppLocalizations.of(context)!.toResetYourPasswordEnterTheCodeBelowToContinue}",
                    style: AppStyle.baseRegular.copyWith(
                      color: AppColors.darkGray,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 24.h),
                  Pinput(
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    showCursor: true,
                    focusedPinTheme: PinTheme(
                      width: 56.w,
                      height: 56.h,
                      textStyle: AppStyle.baseMedium.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.dark,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        border: Border.all(color: AppColors.gray),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: 56.w,
                      height: 56.h,
                      textStyle: AppStyle.baseMedium.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.darkGray,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.otpController,
                  ),
                  SizedBox(height: 24.h),

                  Obx(
                    () => Container(
                      child:
                          controller.isTimerActive.value
                              ? Text(
                                "${"Times remaining"}: 00:${controller.secondsRemaining} s",
                                style: AppStyle.baseSmallRegular.copyWith(
                                  color: AppColors.gray,
                                ),
                              )
                              : TextButton(
                                onPressed: () {
                                  controller.resendOTP(sendTo);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.resend,
                                  style: AppStyle.baseSmallMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Obx(() {
                    return CustomButton(
                      buttonTitle: AppLocalizations.of(context)!.next,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        controller.confirmOTP(isReset: isReset, sendTo: sendTo);
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
