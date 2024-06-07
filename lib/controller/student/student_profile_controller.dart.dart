import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/services/services.dart';

class StudentProfileController extends GetxController {
  final size = Get.find<GlobalController>();
  MyServices myServices = Get.find();

  String? studentID;
  String? schoolID;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? profile;

  @override
  void onInit() {
    profile = myServices.getUser()?["profile"].toString();
    studentID = myServices.getUser()?["studentID"].toString();
    schoolID = myServices.getUser()?["schoolID"].toString();
    firstName = myServices.getUser()?["firstName"].toString();
    lastName = myServices.getUser()?["lastName"].toString();
    emailAddress = myServices.getUser()?["emailAddress"].toString();
    super.onInit();
  }
}
