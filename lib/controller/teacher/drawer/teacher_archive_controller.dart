import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/teacher/teacher.dart';
import 'package:smart_grade_viewer/data/model/teacher_archive_model.dart';

class TeacherArchiveController extends GetxController {
  final size = Get.find<GlobalController>();
  final dashboardController = Get.find<TeacherDashboardController>();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestArchive = StatusRequest.none;
  StatusRequest statusRequestDelete = StatusRequest.none;
  TeacherData teacherRequest = TeacherData(Get.find());
  MyServices myServices = Get.find();
  late RxList<TeacherArchiveModel> archiveList =
      RxList<TeacherArchiveModel>([]);
  String? teacherID;

  Future<void> refreshData() async {
    fetchArchiveClass();
  }

  fetchArchiveClass() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teacherRequest.fetchArchiveClass(teacherID!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewclass'];

        List<TeacherArchiveModel> classes =
            result.map((data) => TeacherArchiveModel.fromJson(data)).toList();
        archiveList.assignAll(classes.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void unArchiveClass(String classID, int index) async {
    statusRequestArchive = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await teacherRequest.teacherArchive(classID, "0");
    statusRequestArchive = handlingData(response);
    if (StatusRequest.success == statusRequestArchive) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        List<TeacherArchiveItem> itemsToRemove = [];

        archiveList.removeWhere((studentArchiveModel) {
          for (var classItem in studentArchiveModel.classes) {
            if (classItem.classID == classID) {
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
              classItem.classID == classID);
        }

        dashboardController.fetchClass();
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
    teacherID = myServices.getUser()?["teacherID"].toString();
    fetchArchiveClass();
    super.onInit();
  }
}
