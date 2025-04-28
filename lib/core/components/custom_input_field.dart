import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/utils/regex_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({
    super.key,
    required this.controller,
    this.validator,
    this.isEmail = false,
    this.isPassword = false,
    this.title,
    this.prefixIcon,
    this.maxLines = 1,
    this.hintText,
    this.background,
    this.isNumber = false,
    this.onChanged,
    this.maxLength,
  });

  final String? title;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool isEmail;
  final bool isPassword;
  final String? prefixIcon;
  final int maxLines;
  final TextEditingController controller;
  final Color? background;
  final bool isNumber;
  final Function(String)? onChanged;
  final int? maxLength;

  // To track obscure and unobsure state of password text
  final RxBool isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // the title with the sizedbox will only be rendered when it is provided
        // if (title != null) Text(title!, style: AppStyle.baseSmallRegular),
        // if (title != null) SizedBox(height: 8.h),
        // To design the text field container is used
        Obx(() {
          final obscure = isObscure.value;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryLight),
              borderRadius: BorderRadius.circular(12),
              color: background,
            ),
            // Row is used for prefix icons and suffix icons
            child: Row(
              crossAxisAlignment:
                  maxLines == 1
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                if (prefixIcon != null)
                  SvgPicture.asset(prefixIcon!, height: 20.h, width: 20.w),
                if (prefixIcon != null) SizedBox(width: 12.w),
                Flexible(
                  child: TextFormField(
                    onChanged: onChanged,
                    keyboardType: isNumber ? TextInputType.number : null,

                    inputFormatters:
                        isNumber
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                    controller: controller,

                    // To remove default styling and setting hint text
                    decoration: InputDecoration(
                      hintText: hintText ?? title ?? "",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        color: AppColors.gray,
                      ),
                    ),

                    style: GoogleFonts.roboto(
                      // Style for the input text
                      fontSize: 16.sp,
                    ),

                    obscureText: isPassword ? obscure : false,

                    //  The maxlines determines the number of lines that can occupy the field
                    maxLines: maxLines,
                    // shows
                    maxLength: maxLength,
                    // This is to validate fields based conditions
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // if the value of field is empty
                        return "This field cannot be empty.";
                      }
                      if (isEmail) {
                        if (!RegexValidators.isValidEmail(value)) {
                          // if email and not validated then the following the error will be shown
                          return "Please enter valid email address";
                        }
                      }
                      if (isPassword) {
                        if (!RegexValidators.isValidPassword(value)) {
                          // password validating on length
                          return "Must be 8+ chars with upper, lower, number & symbol.";
                        }
                      }
                      // default return of null
                      return null;
                    },
                  ),
                ),
                // for obscure and unobscure text
                if (isPassword) SizedBox(width: 12.h),
                if (isPassword)
                  Obx(() {
                    return InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        isObscure.value = !isObscure.value;
                      },
                      child: Icon(
                        isObscure.value ? Icons.visibility : Icons.visibility,
                        size: 20,
                      ),
                    );
                  }),
              ],
            ),
          );
        }),
      ],
    );
  }
}
