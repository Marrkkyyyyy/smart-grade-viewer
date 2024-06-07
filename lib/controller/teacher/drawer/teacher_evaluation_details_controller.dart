import 'dart:convert';

import 'package:get/get.dart';
import 'package:smart_grade_viewer/data/datasource/static/evaluation_questions.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/data/model/evaluation_model.dart';

class TeacherEvaluationDetailsController extends GetxController {
  late EvaluationModel evaluationData;
  late ClassModel classData;
  late List<String> evaluationAnswers;
  late String index;

  final evaluationQuestions = EvaluationQuestions.questions;

  @override
  void onInit() {
    evaluationData = Get.arguments?['evaluationData'];
    classData = Get.arguments?['classData'] ?? ClassModel(color: "");
    index = Get.arguments?['index'];
    evaluationAnswers =
        (json.decode(evaluationData.evaluation!) as List<dynamic>)
            .cast<String>();
    super.onInit();
  }
}
