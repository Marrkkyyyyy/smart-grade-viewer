import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/crud.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(GlobalController());
  }
}
