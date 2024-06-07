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

class TeacherDashboardController extends GetxController {
  final size = Get.find<GlobalController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> semesterList = ["1", "2"];
  late TextEditingController className, classCode, block, searchController;
  late RxList<ClassModel> classList = RxList<ClassModel>([]);
  TeacherData classRequest = TeacherData(Get.find());
  MyServices myServices = Get.find();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestNew = StatusRequest.none;
  late StatusRequest statusRequestArchive = StatusRequest.none;
  Rx<Color> containerColor = Colors.red.obs;
  String? teacherID;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? profile;
  String? semester;

  logout() {
    myServices.logout();
  }

  clearData() {
    className.clear();
    classCode.clear();
    block.clear();
    semester = null;
    containerColor.value = Colors.red;
    update();
  }

  String colorToHex(Color color) {
    return color.value.toRadixString(16).padLeft(8, '0');
  }

  Future<void> refreshData() async {
    await fetchClass();
  }

  archiveClass(String classID) async {
    statusRequestArchive = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await classRequest.teacherArchive(classID, "1");
    statusRequestArchive = handlingData(response);
    if (StatusRequest.success == statusRequestArchive) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        classList.removeWhere((element) => element.classID == classID);
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

  createNewClass() async {
    statusRequestNew = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await classRequest.createNewClass(
        teacherID!,
        className.text,
        classCode.text,
        block.text,
        semester!,
        colorToHex(containerColor.value));
    statusRequestNew = handlingData(response);
    if (StatusRequest.success == statusRequestNew) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        Get.back();
        clearData();
        fetchClass();
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestNew == StatusRequest.offlinefailure) {
      statusRequestNew = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequestNew) {
      statusRequestNew = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
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

  validateInput() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      if (semester == null) {
        showErrorMessage("Please choose a semester", seconds: 1);
      } else {
        createNewClass();
      }
    }
  }

  @override
  void onInit() {
    teacherID = myServices.getUser()?["teacherID"].toString();
    firstName = myServices.getUser()?["firstName"].toString();
    lastName = myServices.getUser()?["lastName"].toString();
    emailAddress = myServices.getUser()?["emailAddress"].toString();
    profile = myServices.getUser()?["profile"].toString();
    fetchClass();
    searchController = TextEditingController();
    className = TextEditingController();
    classCode = TextEditingController();
    block = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    className.dispose();
    classCode.dispose();
    block.dispose();
    super.dispose();
  }
}
