import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/functions/global_controller.dart';
import 'package:smart_grade_viewer/core/functions/handling_data_controller.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/services/services.dart';
import 'package:smart_grade_viewer/data/datasource/remote/auth/auth.dart';
import 'package:smart_grade_viewer/data/datasource/remote/teacher/teacher.dart';
import 'package:smart_grade_viewer/view/widget/teacher/confirmation_dialog.dart';

class TeacherEditProfileController extends GetxController {
  final size = Get.find<GlobalController>();
  MyServices myServices = Get.find();
  AuthData authRequest = AuthData(Get.find());
  TeacherData teacherRequest = TeacherData(Get.find());

  late StatusRequest statusRequestChangePass = StatusRequest.none;
  late StatusRequest statusRequesUpdate = StatusRequest.none;
  late RxBool currentPasswordVisible = false.obs;
  late RxBool newPasswordVisible = false.obs;
  late RxBool confirmPasswordVisible = false.obs;
  late TextEditingController firstNameController,
      lastNameController,
      currentPasswordController,
      newPasswordController,
      confirmPasswordController;
  late GlobalKey<FormState> formPassword = GlobalKey<FormState>();
  late GlobalKey<FormState> formProfile = GlobalKey<FormState>();
  File? image;
  String? teacherID;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? profile;

  clearPasswordData() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  validateInput(String currentPassword, String newPassword) {
    var formData = formPassword.currentState;
    if (formData!.validate()) {
      changePassword(currentPassword, newPassword);
    }
  }

  validateInputProfile(context) {
    var formData = formProfile.currentState;
    if (formData!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmationDialog(
                colorConfirmText: AppColor.lightIndigo,
                message:
                    "Please log-in again to update your profile. Are you sure you want to continue?",
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onConfirm: () {
                  Navigator.of(context).pop();
                  editProfile();
                });
          });
    }
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final currentTime = DateTime.now();
      final newName =
          'SGV_${currentTime.hour}${currentTime.minute}${currentTime.second}${currentTime.millisecond}${currentTime.microsecond}_.jpg';
      final newPath = '${file.parent.path}/$newName';
      final renamedFile = await file.rename(newPath);
      final compressedFile = await compressFile(renamedFile);
      final compressedFileName = compressedFile.path;
      final newFileName = compressedFileName.replaceFirst('_compressed', '');
      final renamedCompressedFile = await compressedFile.rename(newFileName);
      image = File(renamedCompressedFile.path);
      update();
    }
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 15,
    );
    return compressedFile;
  }

  editProfile() async {
    statusRequesUpdate = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await teacherRequest.editProfile(
      image,
      teacherID!,
      firstNameController.text,
      lastNameController.text,
    );
    statusRequesUpdate = handlingData(response);
    if (StatusRequest.success == statusRequesUpdate) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        showSuccessMessage("Successfully Updated", dismiss: false);
        Future.delayed(const Duration(seconds: 1), () async {
          await myServices.logout();
        });
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequesUpdate == StatusRequest.offlinefailure) {
      statusRequesUpdate = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == statusRequesUpdate) {
      statusRequesUpdate = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  changePassword(String currentPassword, String newPassword) async {
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await authRequest.changePassword(
        emailAddress!, currentPassword, newPassword);
    statusRequestChangePass = handlingData(response);
    if (StatusRequest.success == statusRequestChangePass) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        showSuccessMessage("Successfully Updated", dismiss: false);
        Future.delayed(const Duration(seconds: 1), () {
          clearPasswordData();
          Get.back(result: true);
        });
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequestChangePass == StatusRequest.offlinefailure) {
      statusRequestChangePass = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == statusRequestChangePass) {
      statusRequestChangePass = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  @override
  void onInit() {
    profile = myServices.getUser()?["profile"].toString();
    teacherID = myServices.getUser()?["teacherID"].toString();
    firstName = myServices.getUser()?["firstName"].toString();
    lastName = myServices.getUser()?["lastName"].toString();
    emailAddress = myServices.getUser()?["emailAddress"].toString();
    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
