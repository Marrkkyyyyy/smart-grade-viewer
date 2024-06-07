import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_edit_profile_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/view/widget/teacher/confirmation_dialog.dart';
import 'package:smart_grade_viewer/view/widget/teacher/drawer/custom_teacher_profile_textfield.dart';

class TeacherChangePassword extends StatelessWidget {
  const TeacherChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherEditProfileController());

    return WillPopScope(
      onWillPop: () async {
        if (controller.currentPasswordController.text.isNotEmpty ||
            controller.confirmPasswordController.text.isNotEmpty ||
            controller.newPasswordController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  colorConfirmText: Colors.orange,
                  confirmText: "Discard",
                  message: "Discard Changes?",
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () {
                    Navigator.pop(context);
                    controller.clearPasswordData();
                    Get.back();
                  },
                );
              });
        } else {
          Get.back();
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: controller.formPassword,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, top: 6),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (controller.currentPasswordController.text.isNotEmpty ||
                                      controller.confirmPasswordController.text
                                          .isNotEmpty ||
                                      controller.newPasswordController.text
                                          .isNotEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ConfirmationDialog(
                                            colorConfirmText: Colors.orange,
                                            confirmText: "Discard",
                                            message: "Discard Changes?",
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirm: () {
                                              Navigator.pop(context);
                                              controller.clearPasswordData();
                                              Get.back();
                                            },
                                          );
                                        });
                                  } else {
                                    Get.back();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      return CustomProfileTextfield(
                        textEditingController:
                            controller.currentPasswordController,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else {
                            return null;
                          }
                        },
                        icon: Icons.lock,
                        labelText: 'Current Password',
                        hintText: 'Enter current password',
                        controller: controller,
                        isPassword: true,
                        passwordVisibility:
                            controller.currentPasswordVisible.value,
                      );
                    }),
                    Obx(() {
                      return CustomProfileTextfield(
                        textEditingController: controller.newPasswordController,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else if (val.length < 8) {
                            return "Password must be at least 8 characters long";
                          } else {
                            return null;
                          }
                        },
                        icon: Icons.lock,
                        labelText: 'New Password',
                        hintText: 'Enter new password',
                        controller: controller,
                        isPassword: true,
                        passwordVisibility: controller.newPasswordVisible.value,
                      );
                    }),
                    Obx(() {
                      return CustomProfileTextfield(
                        textEditingController:
                            controller.confirmPasswordController,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else if (controller.newPasswordController.text !=
                              val) {
                            return "Password doesn't match";
                          } else {
                            return null;
                          }
                        },
                        icon: Icons.lock,
                        labelText: 'Confirm Password',
                        hintText: 'Confirm new password',
                        controller: controller,
                        isPassword: true,
                        passwordVisibility:
                            controller.confirmPasswordVisible.value,
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: controller.statusRequestChangePass ==
                              StatusRequest.loading
                          ? () {}
                          : () {
                              controller.validateInput(
                                  controller.currentPasswordController.text,
                                  controller.newPasswordController.text);
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.6),
                                spreadRadius: .3,
                                blurRadius: 2,
                                offset: const Offset(1, 3),
                              ),
                            ],
                            color: AppColor.lightIndigo,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
