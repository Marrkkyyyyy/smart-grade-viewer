import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/teacher/teacher.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/data/model/evaluation_model.dart';

class TeacherEvaluationDashboardController extends GetxController {
  late ClassModel classData;
  late RxList<EvaluationModel> evaluationList = RxList<EvaluationModel>([]);
  TeacherData classRequest = TeacherData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? teacherID;

  String colorToHex(Color color) {
    return color.value.toRadixString(16).padLeft(8, '0');
  }

  Future<void> refreshData() async {
    await fetchEvaluation();
  }

  fetchEvaluation() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await classRequest.fetchEvaluation(classData.teacherClassID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['evaluationData'];
        List<EvaluationModel> evaluation =
            result.map((data) => EvaluationModel.fromJson(data)).toList();
        evaluationList.assignAll(evaluation.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    classData = Get.arguments?['classData'];
    fetchEvaluation();
    super.onInit();
  }
}
