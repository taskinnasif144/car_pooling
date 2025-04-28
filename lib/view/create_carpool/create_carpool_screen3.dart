import 'package:car_pooling/controller/carpooling_controller.dart';
import 'package:car_pooling/core/components/custom_alert_dialog.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/custom_input_field.dart';
import 'package:car_pooling/core/components/image_renderer.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/core/wrappers/option_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateCarpoolScreen3 extends StatelessWidget {
  CreateCarpoolScreen3({super.key});
  final CarpoolingController controller = Get.find<CarpoolingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(AppLocalizations.of(context)!.invite ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Who", style: AppStyle.largeMedium),
              SizedBox(height: 12.h),
              CustomInputField(
                controller: controller.searchContactController,
                hintText: "Search contact" ,
                prefixIcon: AppIcons.serchIcon,
              ),
              SizedBox(height: 24.h),
              OptionWrapper(
                // the upper column is for adding add contact button at the end
                child: Column(
                  children: [
                    // This inner column is for rendering the contacts
                    Column(
                      children:
                          controller.myContact
                              .map(
                                (el) => Column(
                                  children: [
                                    Row(
                                      spacing: 12.w,
                                      children: [
                                        CircleAvatar(
                                          radius: 28.r,
                                          backgroundColor:
                                              AppColors
                                                  .background, // Placeholder color
                                          child:
                                              el.image == ''
                                                  ? Text(
                                                    "${el.firstName[0]}${el.lastName[0]}",
                                                    style:
                                                        AppStyle.headerRegular3,
                                                  )
                                                  : imageRenderer(
                                                    url: el.image,
                                                    borderRadius: 100,
                                                    size: 56,
                                                  ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${el.firstName} ${el.lastName}",
                                              style: AppStyle.baseMedium,
                                            ),
                                            Text(
                                              "${el.cellNumber} ",
                                              style: AppStyle.baseSmallRegular,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              )
                              .toList(),
                    ),
                    // add more button goes here
                    // GestureDetector(
                    //   onTap: () {
                    //     // TODO: add "add contact functionality"
                    //   },
                    //   child: Row(
                    //     spacing: 12,
                    //     children: [
                    //       Icon(Icons.add),
                    //       Text("Add Contacts" , style: AppStyle.baseMedium),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Add message goes here
              Text(AppLocalizations.of(context)!.addNote , style: AppStyle.largeMedium),
              SizedBox(height: 12.h),
              CustomInputField(
                controller: controller.addMessageController,
                maxLines: 5,
                maxLength: 300,
                background: AppColors.white,
              ),
              SizedBox(height: 24.h),
              // carpool details goes here
              OptionWrapper(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Text(AppLocalizations.of(context)!.carpoolDetails , style: AppStyle.largeMedium),
                        buildDetails(
                          key: AppLocalizations.of(context)!.eventName ,
                          value: controller.eventNameController.text,
                        ),
                        buildDetails(
                          key: AppLocalizations.of(context)!.from ,
                          value: controller.startLocationController.text,
                        ),
                        buildDetails(
                          key: AppLocalizations.of(context)!.to ,
                          value: controller.endLocationController.text,
                        ),
                      
                        buildDetails(
                          key: AppLocalizations.of(context)!.on ,
                          value:
                              "${controller.startDate.text} at ${controller.startTime.value!.hour % 12}:${controller.startTime.value!.minute} ${controller.startTime.value!.period == DayPeriod.pm ? "PM" : "AM"}",
                        ),
                        if(controller.isReturnTrip.value)
                        buildDetails(
                          key: "Return",
                          value:
                              "${controller.startDate.text} at ${controller.returnStartTime.value!.hour % 12}:${controller.returnStartTime.value!.minute} ${controller.returnStartTime.value!.period == DayPeriod.pm ? "PM" : "AM"}",
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        AppLocalizations.of(context)!.edit ,
                        style: AppStyle.baseMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                buttonTitle:
                    "${AppLocalizations.of(context)!.send} ${controller.myContact.length} ${AppLocalizations.of(context)!.invites }",
                onTap: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return customAlertDialog(
                        asset: AppIcons.congratsIcon,
                        buttonText: AppLocalizations.of(context)!.home ,
                        content: AppLocalizations.of(context)!.invitationHasBeenSuccessfullySent ,
                        title: AppLocalizations.of(context)!.inviteSent ,
                        route: () {
                          Get.toNamed(AppRoutes.homeSCreen);
                        },
                        // TODO: Implement Home route and connect with home route
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildDetails({key, value}) {
    return Row(
      spacing: 12.w,
      children: [
        Text(
          "$key:",
          style: AppStyle.baseSmallMedium.copyWith(color: AppColors.gray),
        ),
        Text(value, style: AppStyle.baseSmallMedium),
      ],
    );
  }
}
