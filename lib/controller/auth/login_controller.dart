import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/auth/auth.dart';

class LoginController extends GetxController {
  final size = Get.find<GlobalController>();
  late TextEditingController emailAddress, password, npassword, cpassword;
  AuthData authRequest = AuthData(Get.find());
  MyServices myServices = Get.find();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  late String teacherID;
  late Rx<Color> emailIconColor = Colors.grey.obs;
  late Rx<Color> passwordIconColor = Colors.grey.obs;
  late Rx<Color> npasswordIconColor = Colors.grey.obs;
  late Rx<Color> cpasswordIconColor = Colors.grey.obs;
  late RxBool hidePassword = true.obs;
  late RxBool hideNPassword = true.obs;
  late RxBool hideCPassword = true.obs;
  late RxBool changePassword = false.obs;

  Future<void> loginNavigatge(
      Map<String, dynamic> response, String dashboardRoute) async {
    final Map<String, dynamic> userData = response['userData'];
    userData['userType'] = response['userType'];
    await myServices.saveUser(userData);
    Get.offAllNamed(dashboardRoute);
  }

  login() async {
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await authRequest.login(emailAddress.text, password.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        if (response['userType'] == "teacher") {
          String res = response['userData']['isPasswordChanged'].toString();
          if (res == "0") {
            changePassword.value = true;
            teacherID = response['userData']['teacherID'].toString();
            update();
          } else {
            loginNavigatge(response, AppRoute.teacherDashboard);
          }
        } else if (response['userType'] == "student") {
          loginNavigatge(response, AppRoute.studentDashboard);
        } else if (response['userType'] == "admin") {
          loginNavigatge(response, AppRoute.adminDashboard);
        }
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

  loginNewPassword() async {
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response =
        await authRequest.loginNewPassword(teacherID, npassword.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        loginNavigatge(response, AppRoute.teacherDashboard);
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

  validateInput() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      changePassword.value ? loginNewPassword() : login();
    }
  }

  @override
  void onInit() {
    emailAddress = TextEditingController();
    password = TextEditingController();
    npassword = TextEditingController();
    cpassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailAddress.dispose();
    password.dispose();
    npassword.dispose();
    cpassword.dispose();
    super.dispose();
  }
}
