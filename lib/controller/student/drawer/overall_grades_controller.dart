import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/student/student.dart';
import 'package:smart_grade_viewer/data/model/overall_grades_model.dart';

class OverallGradesController extends GetxController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  StudentData studentRequest = StudentData(Get.find());
  late RxList<OverallGradesModel> classList = RxList<OverallGradesModel>([]);
  String? studentID;
  RxDouble overAllGrades = 0.0.obs;

  Future<void> refreshData() async {
    await fetchStudentClass();
  }

  fetchStudentClass() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentRequest.fetchOverallGrades(studentID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewstudentclass'];
        List<OverallGradesModel> classes =
            result.map((data) => OverallGradesModel.fromJson(data)).toList();
        // classes = classes
        //     .where(
        //         (classModel) => double.tryParse(classModel.grade ?? "0")! <= 3)
        //     .toList();

        classList.assignAll(classes.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    studentID = myServices.getUser()?["studentID"].toString();
    fetchStudentClass();
    super.onInit();
  }
}
