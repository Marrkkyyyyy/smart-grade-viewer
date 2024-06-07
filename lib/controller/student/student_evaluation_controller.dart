import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/student/student.dart';
import 'package:smart_grade_viewer/data/datasource/static/evaluation_questions.dart';

class StudentEvaluationController extends GetxController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  StudentData studentRequest = StudentData(Get.find());
  late TextEditingController commentController;
  String? teacherClassID;
  String? studentID;
  submitEvaluate() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await studentRequest.evaluate(
        studentID, teacherClassID, radioValues, commentController.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        Get.back(result: true);
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  final likertScale = [
    'Poor',
    'Fair',
    'Good',
    'Very Good',
    'Outstanding',
  ];

  final evaluationQuestions = EvaluationQuestions.questions;

  late List<String> radioValues = [];

  @override
  void onInit() {
    studentID = myServices.getUser()?["studentID"].toString();
    teacherClassID = Get.arguments?['teacherClassID'];
    commentController = TextEditingController();
    radioValues = List.filled(evaluationQuestions.length, '');
    super.onInit();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
