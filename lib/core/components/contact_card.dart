import 'package:car_pooling/core/components/custom_alert_dialog.dart';
import 'package:car_pooling/core/components/custom_button.dart';
import 'package:car_pooling/core/components/image_renderer.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/wrappers/card_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.fullName,
    required this.address,
    required this.image,
    required this.distance,
    this.hasDelete = false,
    this.hasAddContact = false,
    this.isRequest = false,
    this.onDelete,
  });
  final String fullName;
  final String address;
  final String image;
  final String distance;
  final bool hasDelete;
  final bool hasAddContact;
  final bool isRequest;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Fit content
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.background, // Placeholder color
                child:
                    image == ''
                        ? Text(fullName[0], style: AppStyle.headerRegular3)
                        : imageRenderer(
                          url: image,
                          borderRadius: 100,
                          size: 64,
                        ),
              ),
              SizedBox(width: 12), // Space between image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Distance
                        Text(
                          distance,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4), // Space between name and address
                    // Address with location pin
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  address,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (hasDelete)
                          InkWell(
                            onTap: () {
                             
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return customAlertDialog(
                                    title: "Delete Contact" ,
                                    content:
                                        "Are you sure you want to delete this contact?"
                                             ,
                                  
                                    buttonText: "Delete" ,
                                    isConfirm: true,
                                    isDelete: true,
                                    route:
                                        onDelete ??
                                        () {
                                          Get.back();
                                        },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: SvgPicture.asset(AppIcons.deleteIcon),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16), // Space between text and button
          // Add Contact Button
          if (!isRequest && hasAddContact)
            CustomButton(buttonTitle: "Add Contact" , onTap: () {}),
          if (isRequest)
            Row(
              spacing: 12.w,
              children: [
                Flexible(
                  child: CustomButton(
                    buttonTitle: "Delete" ,
                    isFilled: false,
                    isRed: true,
                    onTap: () {
                      // Todo: implement delete request
                         showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return customAlertDialog(
                                    title: "Delete invitation?" ,
                                    content:
                                        "Are you sure you want to delete the invitation?"
                                             ,
                                  
                                    buttonText: "Delete" ,
                                    isConfirm: true,
                                    isDelete: true,
                                    route:
                                        onDelete ??
                                        () {
                                          Get.back();
                                        },
                                  );
                                },
                              );
                    },
                  ),
                ),
                Flexible(
                  child: CustomButton(
                    buttonTitle: "Confirm" ,
                    onTap: () {
                      // todo: implement todo confirm request
                         showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return customAlertDialog(
                                    title: "Confirm invitation" ,
                                    content:
                                        "Are you sure you want to confirm the invitation?"
                                             ,
                                  
                                    buttonText: "Delete" ,
                                    isConfirm: true,
                               
                                    route:
                                        onDelete ??
                                        () {
                                          Get.back();
                                        },
                                  );
                                },
                              );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
