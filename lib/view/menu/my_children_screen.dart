import 'package:car_pooling/controller/menu_controller.dart';
import 'package:car_pooling/core/components/child_card.dart';
import 'package:car_pooling/core/components/custom_app_bar.dart';
import 'package:car_pooling/core/components/show_custom_snackbar.dart';
import 'package:car_pooling/core/components/spouse_card.dart';
import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/view/menu/edit_child_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyChildrenScreen extends StatelessWidget {
  MyChildrenScreen({super.key});

  // Use Get.put only if this screen is responsible for creating the controller instance
  // If the controller is created elsewhere (e.g., in main or a binding), use Get.find()
  final MenuProfileController controller = Get.put(MenuProfileController());

  @override
  Widget build(BuildContext context) {
    // Wrap the Scaffold with DefaultTabController
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: customAppBar1(
          AppLocalizations.of(context)!.myFamilyMembers,
          hasTabBar: true, // Ensure this tells customAppBar1 to add a TabBar
          tabs: [
            Tab(text: AppLocalizations.of(context)!.children), // First tab
            Tab(text: AppLocalizations.of(context)!.spouse), // Second tab
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          // TabBarView needs children corresponding to the tabs in order
          child: TabBarView(
            children: [
              // Content for the FIRST tab ("Children")
              Obx(() {
                // Display message if the list is empty
                if (controller.myChildrenList.isEmpty) {
                  return Center(child: Text("No children added yet."));
                }
                // Build the list if not empty
                return ListView.builder(
                  itemCount: controller.myChildrenList.length,
                  itemBuilder: (context, index) {
                    // Prevent index out of bounds if list is modified concurrently
                    if (index >= controller.myChildrenList.length) {
                      return const SizedBox.shrink();
                    }
                    final child = controller.myChildrenList[index];
                    return ChildCard( 
                      el: child,
                      onTapDelete: () {
                        // Consider adding confirmation dialog before deleting
                        if (controller.myChildrenList.length > 1) {
                          showDeleteConfirmationDialog(
                            title: "Are you sure to remove your child? ",
                            onDelete: () {
                              controller.myChildrenList.removeAt(index);
                            },
                          );
                        } else {
                          showCustomSnackBar(
                            AppLocalizations.of(context)!.atLeastOneChildMustBeSaved,
                          );
                        }
                      },
                      onTapEdit: (){
                        Get.toNamed(AppRoutes.editChild);
                      },
                    );
                  },
                );
              }),

              // Content for the SECOND tab ("Spouse")
              Obx(() {
                // Display message if the list is empty
                if (controller.myChildrenList.isEmpty) {
                  return Center(child: Text("No children added yet."));
                }
                // Build the list if not empty
                return controller.mySpouseList.isEmpty? Center(child: TextButton(
                  onPressed: (){
                    Get.to(()=> EditChildScreen(isSpouse: true,));
                  },
                  child: Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.darkGray),
                      Text(AppLocalizations.of(context)!.createSpouse, style: TextStyle(color: AppColors.darkGray,))
                    ],
                  )),) :ListView.builder(
                  itemCount: controller.mySpouseList.length,
                  itemBuilder: (context, index) {
                    // Prevent index out of bounds if list is modified concurrently
                    if (index >= controller.mySpouseList.length) {
                      return const SizedBox.shrink();
                    }
                    final spouse = controller.mySpouseList[index];
                    return SpouseCard(
                      el: spouse,
                    
                      onTapDelete: () {
                        // Consider adding confirmation dialog before deleting
                        showDeleteConfirmationDialog(
                          onDelete: () {
                            controller.mySpouseList.removeAt(index);
                          },
                          title: AppLocalizations.of(context)!.areYouSureToRemoveYourSpouse,
                        );
                      },
                      
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

void showDeleteConfirmationDialog({
  required VoidCallback onDelete,
  required String title,
  
}) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        ),
        content:  Text(
          AppLocalizations.of(context)!.thisActionCannotBeUndone,
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
          Row(
            spacing: 12.w,
            children: [
              dialogButton(
                onTap: () {
                  Get.back();
                },
                titleText: AppLocalizations.of(context)!.cancel,
                isDanger: false,
              ),
              dialogButton(
                onTap: () {
                  onDelete();
                  Get.back();
                },
                titleText: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
        ],
      );
    },
  );
}

Expanded dialogButton({
  required titleText,
  required onTap,
  bool isDanger = true,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: isDanger ? null : Border.all(color: AppColors.darkGray),
          color: isDanger ? AppColors.danger : null,
        ),
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(
              color: isDanger ? Colors.white : AppColors.darkGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
