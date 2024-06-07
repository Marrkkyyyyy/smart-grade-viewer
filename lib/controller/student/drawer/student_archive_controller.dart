import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/student/student_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/student/student.dart';
import 'package:smart_grade_viewer/data/model/student_archive_model.dart';

class StudentArchiveController extends GetxController {
  final size = Get.find<GlobalController>();
  final dashboardController = Get.find<StudentDashboardController>();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestArchive = StatusRequest.none;
  StatusRequest statusRequestDelete = StatusRequest.none;
  StudentData studentRequest = StudentData(Get.find());
  MyServices myServices = Get.find();
  late RxList<StudentArchiveModel> archiveList =
      RxList<StudentArchiveModel>([]);
  String? studentID;

  Future<void> refreshData() async {
    fetchArchiveClass();
  }

  deleteClass(
      String classroomID, String studentID, String teacherClassID) async {
    statusRequestDelete = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await studentRequest.deleteClass(
        classroomID, studentID, teacherClassID);
    statusRequestDelete = handlingData(response);
    if (StatusRequest.success == statusRequestDelete) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        List<StudentArchiveItem> itemsToRemove = [];

        archiveList.removeWhere((studentArchiveModel) {
          for (var classItem in studentArchiveModel.classes) {
            if (classItem.classroomID == classroomID) {
              if (studentArchiveModel.classes.length == 1) {
                return true;
              } else {
                itemsToRemove.add(classItem);
              }
            }
          }
          return false;
        });

        for (var studentArchiveModel in archiveList) {
          studentArchiveModel.classes.removeWhere((classItem) =>
              itemsToRemove.contains(classItem) &&
              classItem.classroomID == classroomID);
        }
        update();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestDelete == StatusRequest.offlinefailure) {
      statusRequestDelete = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == statusRequestDelete) {
      statusRequestDelete = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  fetchArchiveClass() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentRequest.fetchArchiveClass(studentID!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewarchivestudent'];

        List<StudentArchiveModel> classes =
            result.map((data) => StudentArchiveModel.fromJson(data)).toList();
        archiveList.assignAll(classes.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void unArchiveClass(String classroomID, int index) async {
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await studentRequest.studentArchive(classroomID, "0");
    statusRequestArchive = handlingData(response);
    if (StatusRequest.success == statusRequestArchive) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        List<StudentArchiveItem> itemsToRemove = [];

        archiveList.removeWhere((studentArchiveModel) {
          for (var classItem in studentArchiveModel.classes) {
            if (classItem.classroomID == classroomID) {
              if (studentArchiveModel.classes.length == 1) {
                return true;
              } else {
                itemsToRemove.add(classItem);
              }
            }
          }
          return false;
        });

        for (var studentArchiveModel in archiveList) {
          studentArchiveModel.classes.removeWhere((classItem) =>
              itemsToRemove.contains(classItem) &&
              classItem.classroomID == classroomID);
        }

        dashboardController.fetchStudentClass();
        update();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestArchive == StatusRequest.offlinefailure) {
      statusRequestArchive = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequestArchive) {
      statusRequestArchive = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  @override
  void onInit() {
    studentID = myServices.getUser()?["studentID"].toString();
    fetchArchiveClass();
    super.onInit();
  }
}
