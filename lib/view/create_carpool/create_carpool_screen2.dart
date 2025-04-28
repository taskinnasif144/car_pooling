import 'package:car_pooling/controller/carpooling_controller.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/custom_date_input.dart';
import 'package:car_pooling/core/components/custom_input_field.dart';
import 'package:car_pooling/core/components/custom_time_input.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateCarpoolScreen2 extends StatelessWidget {
  CreateCarpoolScreen2({super.key});
  final CarpoolingController controller = Get.find<CarpoolingController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Add a listener to update an observable variable
    controller.startLocationController.addListener(() {
      controller.startLocationText.value =
          controller.startLocationController.text;
    });

    return Scaffold(
      appBar: customAppBar1(AppLocalizations.of(context)!.createCarpool ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  spacing: 4.w,
                  children: [Text(AppLocalizations.of(context)!.what , style: AppStyle.largeMedium)],
                ),
                SizedBox(height: 12.h),
                CustomInputField(
                  controller: controller.eventNameController,
                  hintText: "Event name" ,
                ),
                SizedBox(height: 24.h),
                // Where
                Text(AppLocalizations.of(context)!.where , style: AppStyle.largeMedium),
                SizedBox(height: 12.h),
                CustomInputField(
                  controller: controller.startLocationController,
                  hintText: "Start location" ,
                ),
                SizedBox(height: 12.h),
                CustomInputField(
                  controller: controller.endLocationController,
                  hintText: "End location" ,
                ),
                SizedBox(height: 12.h),

                Obx(() {
                  return controller.startLocationText.value.length > 3
                      ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.wouldYouLikeToSetThisLocationAsYourHomeAddress
                                 ,
                            style: AppStyle.baseSmallRegular.copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Row(
                              spacing: 24.w,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!.okay ,
                                    style: AppStyle.baseRegular.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!.later ,
                                    style: AppStyle.baseRegular.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      : SizedBox.shrink();
                }),
                if (controller.startLocationText.value.length > 3)
                  SizedBox(height: 12.h),
                if (controller.startLocationText.value.length > 3)
                  SizedBox(height: 24.h),
                Text(AppLocalizations.of(context)!.type  , style: AppStyle.largeMedium),
                // ==========>>>>>>>>> repeat option selector <<<<<<<<=========
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // select one of 4 options
                    Row(
                      spacing: 58.w,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildOption("Does not repeat" ),
                            buildOption("Daily" ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildOption("Every week"),
                            buildOption("Custom"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // This obx detects if custom, then it'll render extra ui
                    Obx(() {
                      if (controller.selectedOption.value != 'Custom' &&
                          controller.selectedOption.value != 'Every week') {
                        return SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Days" , style: AppStyle.baseMedium),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(7, (index) {
                              final dayLabels = [
                                'S',
                                'M',
                                'T',
                                'W',
                                'T',
                                'F',
                                'S',
                              ];
                              final isSelected = controller.selectedDays
                                  .contains(index);

                              return GestureDetector(
                                onTap: () {
                                  if (isSelected) {
                                    controller.selectedDays.remove(index);
                                  } else {
                                    controller.selectedDays.add(index);
                                  }
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? AppColors.primary
                                            : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    dayLabels[index],
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 16.h),
                          if (controller.selectedOption.value != 'Every week')
                            Text("Repeat Until" , style: AppStyle.baseMedium),
                          if (controller.selectedOption.value != 'Every week')
                            SizedBox(height: 8.h),
                          if (controller.selectedOption.value != 'Every week')
                            GestureDetector(
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  controller.customEndDate.value = picked;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_today, size: 20),
                                    SizedBox(width: 8.w),
                                    Text(
                                      controller.customEndDate.value != null
                                          ? controller.customEndDate.value!
                                              .toLocal()
                                              .toString()
                                              .split(" ")[0]
                                          : "Select a date" ,
                                      style: AppStyle.baseRegular,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ],
                ),
                // =========>>>>>>>> start date time <<<<<<<<<==========
                SizedBox(height: 24.h,),
                Text(AppLocalizations.of(context)!.when, style: AppStyle.largeMedium ,),
                SizedBox(height: 16.h,),
               CustomDateInput(
                    dateController: controller.startDate,
                    hintText: "${"Start date" }...",
                    isEnabled: true,
                  ),
             
                SizedBox(height: 16.w,),
                  Row(
                  spacing: 16.w,
                  children: [
                    
                    Flexible(
                      child: Obx(() {
                        return CustomTimeInput(
                          isEnabled: true,
                          hintText: "Starting",
                          time: controller.startTime.value,
                          onChange: (p0) {
                            controller.startTime.value = p0;
                          },
                        );
                      }),
                    ),
                    Flexible(
                      child: Obx(() {
                        return CustomTimeInput(
                          isEnabled: true,
                          hintText: "Ending",
                          time: controller.dropOffTime.value,
                          onChange: (p0) {
                            controller.dropOffTime.value = p0;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                // =========>>>>>>>> Create return trip <<<<<<<<<==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.createReturnTrip ,
                      style: TextStyle(
                        fontSize: 18.0,
                      ), // Adjust font size as needed
                    ),
                    Obx(() {
                      return Switch(
                        value: controller.isReturnTrip.value,
                        onChanged: (bool value) {
                          controller.isReturnTrip.value = value;
                        },
                        activeColor:
                            AppColors
                                .primary, // Color when the toggle is on (adjust as needed)
                      );
                    }),
                  ],
                ),
                SizedBox(height: 12.h),
                    Row(
                  spacing: 16.w,
                  children: [
                    
                    Flexible(
                      child: Obx(() {
                        return CustomTimeInput(
                          isEnabled: controller.isReturnTrip.value,
                          hintText: "Starting",
                          time: controller.returnStartTime.value,
                          onChange: (p0) {
                            controller.returnStartTime.value = p0;
                          },
                        );
                      }),
                    ),
                    Flexible(
                      child: Obx(() {
                        return CustomTimeInput(
                          isEnabled: controller.isReturnTrip.value,
                          hintText: "Ending",
                          time: controller.returnEndTime.value,
                          onChange: (p0) {
                            controller.returnEndTime.value = p0;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  buttonTitle: AppLocalizations.of(context)!.previewInvites ,
                  isRounded: false,
                  onTap: () {
                    controller.previewAndInvites(_formKey);
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption(String option) {
    return InkWell(
      onTap: () {
        controller.selectedOption.value = option;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Obx(
              () => Radio(
                activeColor: AppColors.primary,
                value: option,
                groupValue: controller.selectedOption.value,
                onChanged: (String? value) {
                  controller.selectedOption.value = value!;
                },
              ),
            ),
            Text(
              option ,
              style: AppStyle.baseMedium.copyWith(color: AppColors.darkGray),
            ),
          ],
        ),
      ),
    );
  }
}
