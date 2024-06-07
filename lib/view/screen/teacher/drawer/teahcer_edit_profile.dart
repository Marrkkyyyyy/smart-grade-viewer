import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_edit_profile_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/link_api.dart';
import 'package:smart_grade_viewer/view/widget/teacher/confirmation_dialog.dart';
import 'package:smart_grade_viewer/view/widget/teacher/drawer/custom_teacher_profile_textfield.dart';

class TeacherEditProfile extends StatelessWidget {
  const TeacherEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherEditProfileController());
    return WillPopScope(
      onWillPop: () async {
        if (controller.firstNameController.text == controller.firstName &&
            controller.lastNameController.text == controller.lastName &&
            controller.image == null) {
          Get.back();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  colorConfirmText: AppColor.lightIndigo,
                  confirmText: "Discard",
                  message: "Discard changes?",
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  onConfirm: () {
                    Navigator.of(context).pop();
                    Get.back();
                  },
                );
              });
        }

        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<TeacherEditProfileController>(builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                key: controller.formProfile,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
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
                                    if (controller.firstNameController.text ==
                                            controller.firstName &&
                                        controller.lastNameController.text ==
                                            controller.lastName &&
                                        controller.image == null) {
                                      Get.back();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ConfirmationDialog(
                                              colorConfirmText:
                                                  AppColor.lightIndigo,
                                              confirmText: "Discard",
                                              message: "Discard changes?",
                                              onCancel: () {
                                                Navigator.of(context).pop();
                                              },
                                              onConfirm: () {
                                                Navigator.of(context).pop();
                                                Get.back();
                                              },
                                            );
                                          });
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
                                  "Edit Profile",
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: const Color.fromARGB(60, 0, 0, 0),
                            child: controller.image != null
                                ? ClipOval(
                                    child: Image.file(
                                      controller.image!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : controller.profile != "null"
                                    ? ClipOval(
                                        child: CachedNetworkImage(
                                        height: 120,
                                        width: 120,
                                        imageUrl: AppLink.userProfile +
                                            controller.profile!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.black26,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ))
                                    : const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: GestureDetector(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.lightIndigo,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomProfileTextfield(
                          textEditingController: controller.firstNameController,
                          valid: (val) {
                            return null;
                          },
                          icon: Icons.person,
                          labelText: "First Name",
                          hintText: "Enter first name",
                          controller: controller),
                      CustomProfileTextfield(
                          textEditingController: controller.lastNameController,
                          valid: (val) {
                            return null;
                          },
                          icon: Icons.person,
                          labelText: "Last Name",
                          hintText: "Enter last name",
                          controller: controller),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.teacherChangePassword);
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          width: MediaQuery.of(context).size.width * .9,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Change Password",
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    color: Colors.black54),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.black45,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: controller.statusRequesUpdate ==
                                StatusRequest.loading
                            ? () {}
                            : () {
                                controller.validateInputProfile(context);
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
            );
          }),
        ),
      ),
    );
  }
}
