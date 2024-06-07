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

class RegisterController extends GetxController {
  final size = Get.find<GlobalController>();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AuthData authRequest = AuthData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  late TextEditingController firstName,
      lastName,
      middleName,
      emailAddress,
      password,
      cpassword;
  late RxString schoolID = "".obs;
  late Rx<Color> firstNameIconColor = Colors.grey.obs;
  late Rx<Color> lastNameIconColor = Colors.grey.obs;
  late Rx<Color> middleNameIconColor = Colors.grey.obs;
  late Rx<Color> emailIconColor = Colors.grey.obs;
  late Rx<Color> passwordIconColor = Colors.grey.obs;
  late Rx<Color> cpasswordIconColor = Colors.grey.obs;
  late RxBool hidePassword = true.obs;
  late RxBool hideCPassword = true.obs;

  registerStudent() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await authRequest.registerStudent(
        "2",
        schoolID.value,
        firstName.text,
        middleName.text,
        lastName.text,
        emailAddress.text,
        password.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Successfully Registered", dismiss: false);
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          Get.offAllNamed(AppRoute.loginPage);
        });
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
      if (schoolID.value.isEmpty) {
        showErrorMessage("Please scan your ID", seconds: 1);
      } else {
        registerStudent();
      }
    }
  }

  bool validateID(String id) {
    RegExp regex = RegExp(r'^\d{4}-\d{5}$');
    return regex.hasMatch(id);
  }

  @override
  void onInit() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    middleName = TextEditingController();
    emailAddress = TextEditingController(text: "");
    password = TextEditingController();
    cpassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    middleName.dispose();
    emailAddress.dispose();
    password.dispose();
    cpassword.dispose();
    super.dispose();
  }
}
