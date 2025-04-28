// ignore_for_file: deprecated_member_use

import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Function(int) onChanged;
  final int menuIndex;
  const CustomBottomNavigationBar({
    super.key,
    required this.menuIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.dark,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(color: Colors.white),
      currentIndex: menuIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon:
              menuIndex == 0
                  ? SvgPicture.asset(
                    AppIcons.findfamilyIcon,
                    color: AppColors.primary,
                  )
                  : SvgPicture.asset(
                    AppIcons.findfamilyIcon,
                    color: AppColors.white,
                  ),
          label: 'Find Families' ,
        ),
        BottomNavigationBarItem(
          icon:
              menuIndex == 1
                  ? SvgPicture.asset(
                    AppIcons.scheduleIcon,
                    color: AppColors.primary,
                  )
                  : SvgPicture.asset(
                    AppIcons.scheduleIcon,
                    color: AppColors.white,
                  ),
          label: 'Schedule' ,
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.add),
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon:
              menuIndex == 3
                  ? SvgPicture.asset(
                    AppIcons.inboxIcon,
                    color: AppColors.primary,
                  )
                  : SvgPicture.asset(
                    AppIcons.inboxIcon,
                    color: AppColors.white,
                  ),
          label: 'Inbox' ,
        ),
        BottomNavigationBarItem(
          icon:
              menuIndex == 4
                  ? SvgPicture.asset(
                    AppIcons.menuIcon,
                    color: AppColors.primary,
                  )
                  : SvgPicture.asset(AppIcons.menuIcon, color: AppColors.white),
          label: 'Menu' ,
        ),
      ],
      onTap: onChanged,
    );
  }
}
