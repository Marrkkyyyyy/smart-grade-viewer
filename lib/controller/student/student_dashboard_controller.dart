import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/student/student.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';

class StudentDashboardController extends GetxController {
  final size = Get.find<GlobalController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController classCodeController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  late StatusRequest statusRequestJoin = StatusRequest.none;
  late StatusRequest statusRequestArchive = StatusRequest.none;
  late StatusRequest statusRequestDelete = StatusRequest.none;
  StudentData studentRequest = StudentData(Get.find());
  late RxList<StudentClassModel> classList = RxList<StudentClassModel>([]);
  String? studentID;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? profile;

  Future<void> refreshData() async {
    await fetchStudentClass();
  }

  validateInput() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      joinClass();
    }
  }

  logout() {
    myServices.logout();
  }

  joinClass() async {
    statusRequestJoin = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response =
        await studentRequest.joinClass(studentID!, classCodeController.text);
    statusRequestJoin = handlingData(response);
    if (StatusRequest.success == statusRequestJoin) {
      if (response['status'] == "success") {
        classCodeController.clear();
        showSuccessMessage("Successfully Requested");
        Get.back();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestJoin == StatusRequest.offlinefailure) {
      statusRequestJoin = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequestJoin) {
      statusRequestJoin = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
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
        classList.removeWhere((element) => element.classroomID == classroomID);
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

  archiveClass(String classroomID) async {
    statusRequestArchive = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await studentRequest.studentArchive(classroomID, "1");
    statusRequestArchive = handlingData(response);
    if (StatusRequest.success == statusRequestArchive) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        classList.removeWhere((element) => element.classroomID == classroomID);
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

  fetchStudentClass() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentRequest.fetchStudentClass(studentID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewstudentclass'];
        List<StudentClassModel> classes =
            result.map((data) => StudentClassModel.fromJson(data)).toList();
        classList.assignAll(classes.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    profile = myServices.getUser()?["profile"].toString();
    studentID = myServices.getUser()?["studentID"].toString();
    firstName = myServices.getUser()?["firstName"].toString();
    lastName = myServices.getUser()?["lastName"].toString();
    emailAddress = myServices.getUser()?["emailAddress"].toString();
    fetchStudentClass();
    classCodeController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    classCodeController.dispose();
    super.dispose();
  }
}
