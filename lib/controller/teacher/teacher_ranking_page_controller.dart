import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';

class TeacherRankingPageController extends GetxController {
  final size = Get.find<GlobalController>();
  late List<TeacherStudentModel> studentList;
  late ClassModel classData;
  late DateTime classYearCreated;
  @override
  void onInit() {
    studentList = Get.arguments?['studentList'];
    classData = Get.arguments?['classData'];
    classYearCreated = DateTime.parse(classData.dateCreated!);
    super.onInit();
  }
}
