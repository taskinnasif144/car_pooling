import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreAppScreen extends StatelessWidget {
  const ExploreAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 18,
              children: [
                SizedBox(width: Get.width),
                Text(
                  "Explore the App!",
                  style: AppStyle.headerRegular3.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 28.sp,
                  ),
                ),
                Text(
                  "HadiKid helps you organize carpooling for your children's school and extracurricular activities in just minutes. It reduces your transportation costs while letting you track your daily carpool schedule and stay informed about whose turn it is to drive.",
                  style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
                WebsiteLinks(),
                //  Find families
                Row(
                  spacing: 12,
                  children: [
                    svgViewer(
                      asset: AppIcons.findfamilyIcon,
                      color: AppColors.primaryDark,
                      width: 20,
                    ),
                    Text(
                      "Find Families",
                      style: AppStyle.baseMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Allows users to search for other HadiKid users to invite and add to their contact list.",
                  style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
                ),
                
                //Schedule
                Row(
                  spacing: 12,
                  children: [
                    svgViewer(
                      asset: AppIcons.scheduleIcon,
                      color: AppColors.primaryDark,
                      width: 20,
                    ),
                    Text(
                      "Schedule",
                      style: AppStyle.baseMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Displays the carpool events you're attending, organizing. or driving for.",
                  style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
                ),
            
                // Create
                Row(
                  spacing: 12,
                  children: [
                    svgViewer(
                      asset: AppIcons.findfamilyIcon,
                      color: AppColors.primaryDark,
                      width: 20,
                    ),
                    Text(
                      "Create",
                      style: AppStyle.baseMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Enables users to create carpool events and invite families who might wan to share a ride.",
                  style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
                ),
            
                // inbox
                Row(
                  spacing: 12,
                  children: [
                    svgViewer(
                      asset: AppIcons.findfamilyIcon,
                      color: AppColors.primaryDark,
                      width: 20,
                    ),
                    Text(
                      "Inbox",
                      style: AppStyle.baseMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Shows your chats, carpool invites, and contact requests, allowing you to respond to them.",
                  style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
                ),
            
                //Menu
                Row(
                  spacing: 12,
                  children: [
                    svgViewer(
                      asset: AppIcons.findfamilyIcon,
                      color: AppColors.primaryDark,
                      width: 20,
                    ),
                    Text(
                      "Menu",
                      style: AppStyle.baseMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Provides access to additional features such as carpools, profile. account ttings, contact list. and more.",
                  style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
                ),
                CustomButton(buttonTitle: "Next", onTap: () => Get.toNamed(AppRoutes.homeSCreen))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WebsiteLinks extends StatelessWidget {
  const WebsiteLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () async {
                if (!await launchUrl(Uri.parse("https://hadikid.com"))) {
                  throw Exception('Could not launch https://hadikid.com');
                }
              },
              icon: Icon(Icons.link, color: AppColors.primary),
              label: Text(
                "hadikid.com",
                style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse("https://hadikid.com/hakkimizda.html"),
                )) {
                  throw Exception(
                    'Could not launch https://hadikid.com/hakkimizda.html',
                  );
                }
              },
              icon: Icon(Icons.link, color: AppColors.primary),
              label: Text(
                "About Us",
                style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse("https://hadikid.com/destek.html"),
                )) {
                  throw Exception(
                    'Could not launch https://hadikid.com/destek.html',
                  );
                }
              },
              icon: Icon(Icons.link, color: AppColors.primary),
              label: Text(
                "Support",
                style: AppStyle.baseMedium.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
