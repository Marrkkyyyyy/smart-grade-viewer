import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/services/services.dart';

class TeacherProfileController extends GetxController {
  final size = Get.find<GlobalController>();
  MyServices myServices = Get.find();
  late RxBool currentPasswordVisible = false.obs;
  late RxBool newPasswordVisible = false.obs;
  late RxBool confirmPasswordVisible = false.obs;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? profile;

  @override
  void onInit() {
    firstName = myServices.getUser()?["firstName"].toString();
    lastName = myServices.getUser()?["lastName"].toString();
    emailAddress = myServices.getUser()?["emailAddress"].toString();
    profile = myServices.getUser()?["profile"].toString();
    super.onInit();
  }
}
