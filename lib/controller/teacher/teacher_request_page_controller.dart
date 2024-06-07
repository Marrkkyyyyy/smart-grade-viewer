import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_class_page_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/data/datasource/remote/teacher/teacher.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/data/model/class_request_model.dart';

class TeacherRequestPageController extends GetxController {
  final size = Get.find<GlobalController>();
  late ClassModel classData;
  late DateTime classYearCreated;
  late RxList<ClassRequestModel> requestList = RxList<ClassRequestModel>([]);
  late StatusRequest statusRequestNew = StatusRequest.none;
  StatusRequest statusRequest = StatusRequest.none;
  TeacherData teacherRequest = TeacherData(Get.find());
  final TeacherClassPageController classPageController = Get.find();

  Future<void> refreshData() async {
    await fetchRequests();
  }

  fetchRequests() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teacherRequest.fetchRequests(classData.classID);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewrequest'];
        List<ClassRequestModel> requests =
            result.map((data) => ClassRequestModel.fromJson(data)).toList();
        requestList.sort((a, b) => a.lastName!.compareTo(b.lastName!));
        requestList.assignAll(requests.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  rejectRequest(String requestID) async {
    statusRequestNew = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await teacherRequest.rejectRequest(requestID);
    statusRequestNew = handlingData(response);
    if (StatusRequest.success == statusRequestNew) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        requestList.removeWhere((element) => element.requestID == requestID);
        update();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestNew == StatusRequest.offlinefailure) {
      statusRequestNew = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == statusRequestNew) {
      statusRequestNew = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  acceptRequest(
      String requestID, String studentID, String teacherClassID) async {
    statusRequestNew = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await teacherRequest.acceptRequest(
        requestID, studentID, teacherClassID);
    statusRequestNew = handlingData(response);
    if (StatusRequest.success == statusRequestNew) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        classPageController.fetchTeacherStudent();
        requestList.removeWhere((element) => element.requestID == requestID);
        update();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestNew == StatusRequest.offlinefailure) {
      statusRequestNew = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == statusRequestNew) {
      statusRequestNew = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  @override
  void onInit() {
    classData = Get.arguments?['classData'];
    classYearCreated = DateTime.parse(classData.dateCreated!);
    fetchRequests();
    super.onInit();
  }
}
