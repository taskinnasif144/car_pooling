import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/core/utils/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBindings.bindings,
          getPages: AppRoutes.pages,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    ),
  );
}
