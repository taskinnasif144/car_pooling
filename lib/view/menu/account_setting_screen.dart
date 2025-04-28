import 'package:car_pooling/controller/menu_controller.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/view/menu/local_compoent/section_container.dart';
import 'package:car_pooling/view/menu/local_compoent/toggle_options.dart';
import 'package:car_pooling/view/menu/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AccountSettingScreen extends StatelessWidget {
  AccountSettingScreen({super.key});

  final MenuProfileController controller = Get.put(MenuProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(AppLocalizations.of(context)!.accountSettings ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              spacing: 20.h,
              children: [
                SizedBox(),
                // Notification of Changes Section
                SectionContainer(
                  title: AppLocalizations.of(context)!.notificationOfChanges ,
                  children: [
                    ToggleOption(
                      title: AppLocalizations.of(context)!.changesToCarpoolsISetUp ,
                      value: controller.carpoolChanges.value,
                      isLocked: controller.isLimitedAccess.value,
                      onChanged:
                          (value) => controller.carpoolChanges.value = value,
                    ),
                    ToggleOption(
                      title: AppLocalizations.of(context)!.changesAffectingMyFamily ,
                      value: controller.familyChanges.value,
                      isLocked: controller.isLimitedAccess.value,
                      onChanged:
                          (value) => controller.familyChanges.value = value,
                    ),
                    ToggleOption(
                      title: AppLocalizations.of(context)!.changesAffectingMyDriving ,
                      value: controller.drivingChanges.value,
                      isLocked: controller.isLimitedAccess.value,
                      onChanged:
                          (value) => controller.drivingChanges.value = value,
                    ),
                  ],
                ),

                // Driving Reminders Section
                SectionContainer(
                  title: AppLocalizations.of(context)!.drivingReminders ,
                  children: [
                    ToggleOption(
                      title: '10 ${"minutes before" }',
                      value: controller.driving10Min.value,
                      onChanged:
                          (value) => controller.driving10Min.value = value,
                    ),
                    ToggleOption(
                      title: '1 ${"hour before" }',
                      value: controller.driving1Hour.value,
                      onChanged:
                          (value) => controller.driving1Hour.value = value,
                    ),
                    ToggleOption(
                      title: '24 ${"hours before" }',
                      value: controller.driving24Hours.value,
                      onChanged:
                          (value) => controller.driving24Hours.value = value,
                    ),
                  ],
                ),

                // Participation Reminders Section
                SectionContainer(
                  title: AppLocalizations.of(context)!.participationReminders ,
                  children: [
                    ToggleOption(
                      title: '10 ${"minutes before" }',
                      value: controller.participation10Min.value,
                      onChanged:
                          (value) =>
                              controller.participation10Min.value = value,
                    ),
                    ToggleOption(
                      title: '1 ${"hour before" }',
                      value: controller.participation1Hour.value,
                      onChanged:
                          (value) =>
                              controller.participation1Hour.value = value,
                    ),
                    ToggleOption(
                      title: '24 ${"hours before" }',
                      value: controller.participation24Hours.value,
                      onChanged:
                          (value) =>
                              controller.participation24Hours.value = value,
                    ),
                  ],
                ),

                // Carpool Notes Notifications Section
                SectionContainer(
                  title: AppLocalizations.of(context)!.carpoolNotesNotifications ,
                  children: [
                    ToggleOption(
                      title: AppLocalizations.of(context)!.notifyMeOfNewMessages ,
                      value: controller.notifyNewMessages.value,
                      isLocked: controller.isLimitedAccess.value,
                      onChanged:
                          (value) => controller.notifyNewMessages.value = value,
                    ),
                  ],
                ),

                // Live Tracking Section
                SectionContainer(
                  title: AppLocalizations.of(context)!.liveTracking,
                  children: [
                    ToggleOption(
                      title: AppLocalizations.of(context)!.childPickupDropOff ,
                      value: controller.childPickupDropoff.value,
                      isLocked: controller.isLimitedAccess.value,
                      onChanged:
                          (value) =>
                              controller.childPickupDropoff.value = value,
                    ),
                  ],
                ),

                // Preference Section
                SectionContainer(
                  title: AppLocalizations.of(context)!.preference ,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.receiveNotificationsAndInvitationsVia ,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ToggleOption(
                      title: AppLocalizations.of(context)!.email ,
                      value: controller.emailNotifications.value,
                      onChanged:
                          (value) =>
                              controller.emailNotifications.value = value,
                    ),
                    ToggleOption(
                      title: AppLocalizations.of(context)!.push ,
                      value: controller.pushNotifications.value,
                      onChanged:
                          (value) => controller.pushNotifications.value = value,
                    ),
                  ],
                ),

                // Custom Button
                CustomButton(
                  buttonTitle: AppLocalizations.of(context)!.manageSubscription ,
                  onTap: () {
                     Get.to(()=> PackageScreen(initialIndex: 1,));
                  },
                ),
                SizedBox(height: 20.h),
              ],
            );
          }),
        ),
      ),
    );
  }
}
