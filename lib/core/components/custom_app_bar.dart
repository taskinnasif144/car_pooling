import "package:car_pooling/core/constant/app_colors.dart";
import "package:car_pooling/core/constant/app_style.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";

// to use the customAppBar1's tabbar, just pass hasTabBar = true, and pass a list of Tab() as a perameter
// This will not be enough you must wrap the scaffold with DefaultTabController as well
// and set the length the parameter to the number of tabs  you need
AppBar customAppBar1(
  title, {
  hasBack = true,
  hasTabBar = false,
  hasShadow = false,
  hasInvite = false,
  backgroundColor = Colors.white,
  List<Widget>? tabs,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: hasShadow ? 3.0 : 0,
    shadowColor: hasShadow ? Colors.black.withAlpha((0.7 * 255).toInt()) : null,
    leading:
        hasBack
            ? GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.chevron_left_sharp, size: 32.sp),
            )
            : Container(),
    title: Text(title, style: AppStyle.largeMedium),
    bottom:
        hasTabBar
            ? TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.gray,
              tabs: tabs!,
            )
            : null,
    actions:
        hasInvite
            ? [
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Invite",
                    style: AppStyle.baseSmallMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ]
            : [],
  );
}
