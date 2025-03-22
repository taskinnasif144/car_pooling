import 'dart:async';

import 'package:car_pooling/core/components/custom_alert_dialog.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/show_custom_snackbar.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/view/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // =================>>>>>>>>>>>>> Normal Variables <<<<<<<<<<<<<===============

  Timer? timer;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  // =================>>>>>>>>>>>>> RX variables <<<<<<<<<<<<<===============
  RxBool isLoading = false.obs;
  RxBool checkBoxStatus = false.obs;
  RxInt secondsRemaining = 59.obs; // Timer duration
  RxBool isTimerActive = false.obs;

  // =================>>>>>>>>>>>>> Functions <<<<<<<<<<<<<===============
  Future userSignIn(formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final body = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;

    debugPrint("=========>>>>>>>>>>>>> userSignIn: $body");

    showCustomSnackBar("User Signed in successfully", isError: false);
  }

  Future userSignUp(formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!checkBoxStatus.value) {
      showCustomSnackBar(
        "You must agree to the terms and conditions to continue",
        isError: true,
      );
      return;
    }

    final body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;

    debugPrint("=========>>>>>>>>>>>>> userSignIn: $body");

    showCustomSnackBar("User created successfully", isError: false);
  }

  Future userGetOTP(formKey, {isPhone, isReset}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (isPhone && phoneController.text.length < 4) {
      showCustomSnackBar("Enter Number");
      return;
    }

    final body = {
      if (isPhone)
        "phone": phoneController.text
      else
        "email": emailController.text,
    };

    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;

    debugPrint("=========>>>>>>>>>>>>> userSignIn: $body");

    Get.to(
      OtpScreen(
        isReset: isReset,
        sendTo: isPhone ? phoneController.text : emailController.text,
      ),
    );

    showCustomSnackBar("OTP sent successfully", isError: false);
  }

  Future resendOTP(sendTo) async {
    //  Start timer
    if (!isTimerActive.value) {
      isTimerActive.value = true;
      secondsRemaining.value = 59;

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        debugPrint("=========>>>>>>>>>>> Timer: $timer");
        if (secondsRemaining > 0) {
          secondsRemaining.value--;
        } else {
          isTimerActive.value = false;
          timer.cancel();
        }
      });
    }
    // Prepare the body and hit api
    final body = {"sendTo": sendTo};
    debugPrint("=========>>>>>>>>>>>>> userSignIn: $body");
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;

    showCustomSnackBar("OTP Rsend to $sendTo", isError: false);
  }

  Future confirmOTP({sendTo, isReset}) async {
    if (otpController.text.length < 4) {
      showCustomSnackBar("Eter otp");
      return;
    }
    final body = {"otp": int.parse(otpController.text), "sendTo": sendTo};
    debugPrint("=========>>>>>>>>>>>>> userSignIn: $body");
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;

    if (isReset) Get.toNamed(AppRoutes.createNewPass);

    showCustomSnackBar("OTP Confirmed", isError: false);
  }

  Future createNewpass() async {
    final body = {
      "newPass": newPassController.text,
      "confirmPassword": confirmNewPassController.text,
    };

    debugPrint("=========>>>>>>>>>>>>> userSignIn: $body");

    if (newPassController.text != confirmNewPassController.text) {
      showCustomSnackBar("Passwords do not match", isError: true);
      return;
    }
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return customAlertDialog(
          title: "Password Changed",
          content: "You have succesfully chamged your password",
          buttonText: "Ok",
          route: () => Get.toNamed(AppRoutes.signIn),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    otpController.clear();
    newPassController.clear();
    confirmNewPassController.clear();
    super.dispose();
  }
}
