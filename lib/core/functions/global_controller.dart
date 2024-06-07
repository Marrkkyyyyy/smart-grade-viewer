import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/core/services/services.dart';

class GlobalController extends GetxController {
  MyServices myServices = Get.find();
  String? userType;
  Future checkUser() async {
    userType = myServices.getUser()?["userType"].toString();
  }

  @override
  void onInit() {
    checkUser().whenComplete(() {
      if (userType == "student") {
        Get.offAllNamed(AppRoute.studentDashboard);
      } else if (userType == "teacher") {
        Get.offAllNamed(AppRoute.teacherDashboard);
      } else if (userType == "admin") {
        Get.offAllNamed(AppRoute.adminDashboard);
      }
    });

    super.onInit();
  }
}
