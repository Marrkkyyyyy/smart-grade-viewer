import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/teacher/teacher.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';

class TeacherEvaluationController extends GetxController {
  final size = Get.find<GlobalController>();
  late RxList<ClassModel> classList = RxList<ClassModel>([]);
  TeacherData classRequest = TeacherData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? teacherID;

  String colorToHex(Color color) {
    return color.value.toRadixString(16).padLeft(8, '0');
  }

  Future<void> refreshData() async {
    await fetchClass();
  }

  fetchClass() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await classRequest.fetchTeacherClass(teacherID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewclass'];
        List<ClassModel> classes =
            result.map((data) => ClassModel.fromJson(data)).toList();
        classList.assignAll(classes.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    teacherID = myServices.getUser()?["teacherID"].toString();
    fetchClass();
    super.onInit();
  }
}
