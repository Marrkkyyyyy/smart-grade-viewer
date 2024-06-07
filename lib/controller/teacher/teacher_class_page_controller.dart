import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/teacher/teacher.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';

class TeacherClassPageController extends GetxController {
  final size = Get.find<GlobalController>();
  Rx<Color> searchIconColor = Colors.grey.obs;
  final FocusNode focusNode = FocusNode();
  late RxBool isFocused = false.obs;
  late ClassModel classData;
  late DateTime classYearCreated;
  late RxInt feedbackCharacterCount = 0.obs;
  late TextEditingController gradeController,
      searchController,
      feedbackController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  late StatusRequest statusRequestNew = StatusRequest.none;
  late StatusRequest statusRequestUnenroll = StatusRequest.none;
  StatusRequest statusRequestReply = StatusRequest.none;
  TeacherData teacherRequest = TeacherData(Get.find());
  late RxString grade = "".obs;
  String? teacherID;
  MyServices myServices = Get.find();
  late RxList<TeacherStudentModel> studentList =
      RxList<TeacherStudentModel>([]);
  late final RxList<TeacherStudentModel> originalList =
      RxList<TeacherStudentModel>([]);

  unenrollStudent(
      String classroomID, String studentID, String teacherClassID) async {
    statusRequestUnenroll = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await teacherRequest.unenrollStudent(
        classroomID, studentID, teacherClassID);
    statusRequestUnenroll = handlingData(response);
    if (StatusRequest.success == statusRequestUnenroll) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        studentList
            .removeWhere((element) => element.classroomID == classroomID);
        update();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestUnenroll == StatusRequest.offlinefailure) {
      statusRequestUnenroll = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == statusRequestUnenroll) {
      statusRequestUnenroll = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  void updateCharacterCount() {
    feedbackCharacterCount.value = feedbackController.text.length;
  }

  replyFeedback(String studentID) async {
    statusRequestReply = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await teacherRequest.replyFeedback(studentID,
        classData.teacherClassID!, teacherID!, feedbackController.text);
    statusRequestReply = handlingData(response);

    if (StatusRequest.success == statusRequestReply) {
      if (response['status'] == "success") {
        Get.back();
        feedbackController.clear();
        showSuccessMessage("Response sent");
        refreshData();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestReply == StatusRequest.offlinefailure) {
      statusRequestReply = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequestReply) {
      statusRequestReply = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  void search(String query) {
    String queryString = query.toLowerCase();
    final RxList<TeacherStudentModel> searchResults =
        RxList<TeacherStudentModel>([]);
    if (originalList.isEmpty) {
      originalList.addAll(studentList);
    }
    searchResults.addAll(originalList.where((item) {
      return item.lastName!.toLowerCase().contains(queryString) ||
          item.firstName!.toLowerCase().contains(queryString);
    }));
    if (queryString.isEmpty) {
      searchResults.assignAll(originalList);
    }
    studentList.assignAll(searchResults);
    update();
  }

  Future<void> refreshData() async {
    await fetchTeacherStudent();
  }

  validateInput(String classroomID) {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      submitGrade(classroomID);
    }
  }

  clearData() {
    gradeController.clear();
  }

  submitGrade(String classroomID) async {
    statusRequestNew = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response =
        await teacherRequest.submitGrade(classroomID, gradeController.text);
    statusRequestNew = handlingData(response);
    if (StatusRequest.success == statusRequestNew) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        clearData();
        Get.back();
        refreshData();
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

  fetchTeacherStudent() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teacherRequest.fetchTeacherStudent(classData.classID);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewteacherstudent'];
        List<TeacherStudentModel> students =
            result.map((data) => TeacherStudentModel.fromJson(data)).toList();
        studentList.sort((a, b) => a.lastName!.compareTo(b.lastName!));
        studentList.assignAll(students.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    feedbackController = TextEditingController();
    gradeController = TextEditingController();
    searchController = TextEditingController();
    classData = Get.arguments?['classData'];
    teacherID = myServices.getUser()?["teacherID"].toString();
    classYearCreated = DateTime.parse(classData.dateCreated!);
    fetchTeacherStudent();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    gradeController.dispose();
    searchController.dispose();
    super.dispose();
  }
}

 String? teacherClassID;
  String? teacherID;
  String? classID;
  String? firstName;
  String? lastName;
  String? profile;
  String? name;
  String? code;
  String? linkCode;
  String? block;
  String? semester;
  String? color;
  String? dateCreated;
  String? isArchived;