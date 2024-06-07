import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/student/student.dart';
import 'package:smart_grade_viewer/data/model/feedback_model.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';

class StudentClassPageController extends GetxController {
  final size = Get.find<GlobalController>();
  final FocusNode focusNode = FocusNode();
  late RxBool isFocused = false.obs;
  late TextEditingController feedbackController;
  late RxInt feedbackCharacterCount = 0.obs;
  late StudentClassModel classItem;
  late DateTime classYearCreated;
  late String fullName;
  late RxList<StudentClassModel> studentList = RxList<StudentClassModel>([]);
  late RxList<FeedbackModel> feedbackList = RxList<FeedbackModel>([]);
  late RxString studentGrade = "".obs;
  late RxString evaluationID = "".obs;
  MyServices myServices = Get.find();
  String? studentID;
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestFeedback = StatusRequest.none;
  StatusRequest statusRequestSend = StatusRequest.none;
  StudentData studentRequest = StudentData(Get.find());
  Future<void> refreshData() async {
    fetchFeedback();
    fetchStudent();
  }

  void updateCharacterCount() {
    feedbackCharacterCount.value = feedbackController.text.length;
  }

  sendFeedback() async {
    statusRequestSend = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await studentRequest.sendFeedback(studentID!,
        classItem.teacherClassID!, studentID!, feedbackController.text);
    statusRequestSend = handlingData(response);

    if (StatusRequest.success == statusRequestSend) {
      if (response['status'] == "success") {
        Get.back();
        feedbackController.clear();
        fetchFeedback();
        showSuccessMessage("Message Sent");
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestSend == StatusRequest.offlinefailure) {
      statusRequestSend = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequestSend) {
      statusRequestSend = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  fetchStudent() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentRequest.fetchStudent(
        classItem.classID!, studentID!, classItem.teacherClassID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewstudentclass'];
        studentGrade.value = response['studentGrade'] ?? "";
        evaluationID.value = response['evaluationID'] ?? "";
        List<StudentClassModel> classes =
            result.map((data) => StudentClassModel.fromJson(data)).toList();

        studentList.assignAll(classes.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  fetchFeedback() async {
    statusRequestFeedback = StatusRequest.loading;
    update();
    var response = await studentRequest.fetchFeedback(
        studentID!, classItem.teacherClassID!);
    statusRequestFeedback = handlingData(response);

    if (StatusRequest.success == statusRequestFeedback) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewfeedback'];
        List<FeedbackModel> feedback =
            result.map((data) => FeedbackModel.fromJson(data)).toList();

        feedbackList.assignAll(feedback.toList());
      } else {
        statusRequestFeedback = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    studentID = myServices.getUser()?["studentID"].toString();
    classItem = Get.arguments?['classItem'];
    fetchStudent();
    fetchFeedback();
    classYearCreated = DateTime.parse(classItem.dateCreated!);
    fullName = "${classItem.firstName} ${classItem.lastName}";
    feedbackController = TextEditingController();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    feedbackController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
