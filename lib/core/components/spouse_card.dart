import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/wrappers/card_wrapper.dart';
import 'package:car_pooling/model/spouse_model.dart';
import 'package:car_pooling/view/menu/edit_child_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SpouseCard extends StatelessWidget {
  const SpouseCard({super.key, required this.el, this.onTapDelete});

  final SpouseModel el;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 12.w,
            children: [
              CircleAvatar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${el.childFistName} ${el.childLastName}',
                    style: AppStyle.largeMedium,
                  ),
                  // Text(
                  //   el.childSchoolName,
                  //   style: AppStyle.baseMedium.copyWith(color: AppColors.gray),
                  // ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.h,
            children: [
              InkWell(
                onTap: () => Get.to(() =>EditChildScreen(isSpouse: true,)),
                child: SvgPicture.asset(AppIcons.editIcon),
              ),
              if (onTapDelete != null)
                InkWell(
                  onTap: onTapDelete,
                  child: SvgPicture.asset(AppIcons.deleteIcon),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
