import 'package:car_pooling/home_screen.dart';
import 'package:car_pooling/view/auth/add_child_screen.dart';
import 'package:car_pooling/view/auth/create_new_password_screen.dart';
// import 'package:car_pooling/view/auth/forgot_password_screen.dart';
// import 'package:car_pooling/view/auth/otp_screen.dart';
import 'package:car_pooling/view/auth/sign_in_screen.dart';
import 'package:car_pooling/view/auth/sign_up_screen.dart';
import 'package:car_pooling/view/auth/splash_screen.dart';
import 'package:car_pooling/view/auth/welcome_screen.dart';
import 'package:car_pooling/view/auth/welcome_screen2.dart';
import 'package:car_pooling/view/create_carpool/create_carpool_screen1.dart';
import 'package:car_pooling/view/create_carpool/create_carpool_screen2.dart';
import 'package:car_pooling/view/create_carpool/create_carpool_screen3.dart';
import 'package:car_pooling/view/create_carpool/create_carpool_screen4.dart';
import 'package:car_pooling/view/find_families/find_family_screen.dart';
import 'package:car_pooling/view/inbox/inbox_screen.dart';
import 'package:car_pooling/view/inbox/messages_screen.dart';
import 'package:car_pooling/view/menu/my_carpools_screen.dart';
import 'package:car_pooling/view/schedule/schedule_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  // =================>>>>>>>>>>>>> Auth Feature <<<<<<<<<<<<<===============
  static String splashScreen = "/splash_screen";
  static String signIn = "/sign_in";
  static String signUp = "/sign_up";
  static String createNewPass = "/create_new_pass";
  static String addChild = "/add_a_child";
  static String welcomeScreen = "/welcome_screen";
  static String welcomeScreen2 = "/welcome_screen_2";

  static String homeSCreen = '/home_screen';
  // =================>>>>>>>>>>>>> Find Families <<<<<<<<<<<<<===============
  static String findFamily = "/find_family";

  // =================>>>>>>>>>>>>>  Schedule <<<<<<<<<<<<<===============
  static String schedule = "/schedule";

  // =================>>>>>>>>>>>>> Inbox <<<<<<<<<<<<<===============
  static String inbox = "/inbox";
  static String messages = "/messages";

  // =================>>>>>>>>>>>>> Create carpool <<<<<<<<<<<<<===============
  static String createCarpool1 = "/craete_carpool_1";
  static String createCarpool2 = "/craete_carpool_2";
  static String createCarpool3 = "/craete_carpool_3";
  static String createCarpool4 = "/craete_carpool_4";

  // =================>>>>>>>>>>>>> Menu <<<<<<<<<<<<<===============
  static String myCarpools = "/my_car_pools";
  static String myProfiles = "/my_profile";

  static List<GetPage> pages = [
    // =================>>>>>>>>>>>>> Auth Feature <<<<<<<<<<<<<===============
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: createNewPass, page: () => CreateNewPasswordScreen()),
    GetPage(name: addChild, page: () => AddChildScreen()),
    GetPage(name: welcomeScreen, page: () => WelcomeScreen()),
    GetPage(name: welcomeScreen2, page: () => WelcomeScreen2()),

    GetPage(name: homeSCreen, page: () => HomeScreen()),
    // =================>>>>>>>>>>>>> Find Families <<<<<<<<<<<<<===============
    GetPage(name: findFamily, page: () => FindFamilyScreen()),

    // =================>>>>>>>>>>>>>  Schedule <<<<<<<<<<<<<===============
    GetPage(name: schedule, page: () => ScheduleScreen()),

    // =================>>>>>>>>>>>>> Inbox <<<<<<<<<<<<<===============
    GetPage(name: inbox, page: () => InboxScreen()),
    GetPage(name: messages, page: () => MessagesScreen()),

    // =================>>>>>>>>>>>>> Create carpool <<<<<<<<<<<<<===============
    GetPage(name: createCarpool1, page: () => CreateCarpoolScreen1()),
    GetPage(name: createCarpool2, page: () => CreateCarpoolScreen2()),
    GetPage(name: createCarpool3, page: () => CreateCarpoolScreen3()),
    GetPage(name: createCarpool4, page: () => CreateCarpoolScreen4()),
    // =================>>>>>>>>>>>>> Menu <<<<<<<<<<<<<===============
    GetPage(name: myCarpools, page: () => MyCarpoolsScreen()),
  ];
}
