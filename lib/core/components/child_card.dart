import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:car_pooling/core/wrappers/card_wrapper.dart';
import 'package:car_pooling/model/child_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({super.key, required this.el, this.onTapDelete, this.onTapEdit,});

  final ChildModel el;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapEdit;

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
                  Text(
                    el.childSchoolName,
                    style: AppStyle.baseMedium.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.h,
            children: [
              if(onTapEdit != null)
              InkWell(
                onTap:onTapEdit,
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
