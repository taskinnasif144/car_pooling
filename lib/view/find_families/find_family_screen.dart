import 'package:car_pooling/controller/find_family_controller.dart';
import 'package:car_pooling/core/components/contact_card.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/custom_input_field.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindFamilyScreen extends StatelessWidget {
  FindFamilyScreen({super.key});
  final FindFamilyController controller = Get.find<FindFamilyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(
        AppLocalizations.of(context)!.findFamilies,
        hasBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          children: [
            // TODO: Add Search Functionality
            CustomInputField(
              controller: controller.familySearchController,
              prefixIcon: AppIcons.serchIcon,
              hintText: "${"Search name, email or phone"}...",
            ),
            SizedBox(height: 4),
            Text(
              AppLocalizations.of(
                context,
              )!.typeAName10DigitPhoneNumberOrEmailAddressToSearch,
              style: AppStyle.smallRegular,
            ),
            SizedBox(height: 12.h),
            Obx(() {
              return Column(
                children:
                    controller.myContacts.map((el) {
                      return ContactCard(
                        fullName: "${el.firstName} ${el.lastName}",
                        address: el.address,
                        image: el.image,
                        distance: el.distance,
                        hasAddContact: true,
                      );
                    }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
