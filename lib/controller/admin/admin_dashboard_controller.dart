import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/admin/admin_data.dart';
import 'package:smart_grade_viewer/data/datasource/remote/auth/auth.dart';
import 'package:smart_grade_viewer/data/model/teacher_model.dart';

class AdminDashboardController extends GetxController {
  final size = Get.find<GlobalController>();
  AuthData authRequest = AuthData(Get.find());
  AdminData adminRequest = AdminData(Get.find());
  late TextEditingController firstName, lastName, emailAddress;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  late RxList<TeacherModel> teacherList = RxList<TeacherModel>([]);
  MyServices myServices = Get.find();

  logout() {
    myServices.logout();
  }

  Future<void> refreshData() async {
    await fetchTeachers();
  }

  void clearData() {
    firstName.clear();
    lastName.clear();
    emailAddress.clear();
  }

  registerTeacher(context) async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await authRequest.registerTeacher(
        "1", firstName.text, lastName.text, emailAddress.text);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Successfully Created");
        clearData();
        TeacherModel newTeacher = TeacherModel.fromJson(response['userData']);
        int insertIndex = teacherList.indexWhere((teacher) =>
            teacher.lastName!.compareTo(newTeacher.lastName!) >= 0);
        if (insertIndex == -1) {
          teacherList.add(newTeacher);
        } else {
          teacherList.insert(insertIndex, newTeacher);
        }
        update();
        Navigator.of(context).pop();
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

  fetchTeachers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await adminRequest.fetchTeacher();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['teacher'];
        List<TeacherModel> teachers =
            result.map((data) => TeacherModel.fromJson(data)).toList();
        teachers.sort((a, b) => a.lastName!.compareTo(b.lastName!));
        teacherList.assignAll(teachers.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  validateInput(context) {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      registerTeacher(context);
    }
  }

  @override
  void onInit() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    emailAddress = TextEditingController();
    fetchTeachers();
    super.onInit();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    emailAddress.dispose();
    super.dispose();
  }
}
