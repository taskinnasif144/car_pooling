import 'package:car_pooling/core/components/show_custom_snackbar.dart';
import 'package:car_pooling/core/helper/app_routes.dart';
import 'package:car_pooling/model/child_model.dart';
import 'package:car_pooling/model/contact_model.dart';
import 'package:car_pooling/model/role_model.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CarpoolingController extends GetxController {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController startLocationController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController searchContactController = TextEditingController();
  TextEditingController addMessageController = TextEditingController();
  TextEditingController startDate = TextEditingController();


  RxString startLocationText = "".obs;
  RxString mySelectedRole = "Attend".obs;
  // Observable for selected days of the week
  RxSet<int> selectedDays = <int>{}.obs; // 0 = Sunday, 6 = Saturday

  // Observable for end date
  Rx<DateTime?> customEndDate = Rx<DateTime?>(null);

  RxList<ChildModel> availableChildren =
      <ChildModel>[
        ChildModel(fullName: "Jacob"),
        ChildModel(fullName: "Sofia"),
      ].obs;
  RxList<RoleModel> myRole =
      <RoleModel>[RoleModel(name: "Attend"), RoleModel(name: "Drive")].obs;

  RxList<ContactModel> myContact =
      <ContactModel>[
        ContactModel(
          firstName: "Adam",
          lastName: "Brown",
          cellNumber: "+880 178 020 2564",
        ),
        ContactModel(
          firstName: "Adam",
          lastName: "Brown",
          cellNumber: "+880 178 020 2564",
        ),
      ].obs;

  RxString selectedOption = "Custom".obs;
  RxBool isReturnTrip = false.obs;
  final Rx<Time?> timePicker = Rx<Time?>(null);
  final Rx<Time?> startTime = Rx<Time?>(null);
  final Rx<Time?> dropOffTime = Rx<Time?>(null);
  final Rx<Time?> returnStartTime = Rx<Time?>(null);
  final Rx<Time?> returnEndTime= Rx<Time?>(null);

  final List<String> availableOptions = [
    "Does not repeat",
    "Daily",
    "Every week",
    "Custom",
  ];

  Future create1Tocreate2() async {
    bool isSelected = false;

    for (int i  = 0; i< availableChildren.length; i++ ) {
      if(availableChildren[i].isSelected) {
        isSelected = true;
      }
    }


    if(isSelected) {

    Get.toNamed(AppRoutes.createCarpool2);
    } else {
      showCustomSnackBar("Select at least one child to continue!", isError: true);
    }
    
  }

  Future previewAndInvites(formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if ( startTime.value == null || dropOffTime.value == null ) {
      showCustomSnackBar("Please select time", isError: true);
      return;
    } else if (startDate.text.isEmpty) {
       showCustomSnackBar("Please select Date", isError: true);
      return;
    }
    Get.toNamed(AppRoutes.createCarpool3);
  }



  void clearController() {
    eventNameController.clear();
    endLocationController.clear();
    startLocationController.clear();
    returnDateController.clear();
    searchContactController.clear();
    addMessageController.clear();
  }

  @override
  void onClose() {
    clearController();
    super.onClose();
  }
}
