import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_edit_profile_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';

class CustomProfileTextfield extends StatelessWidget {
  const CustomProfileTextfield({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.hintText,
    this.textEditingController,
    required this.controller,
    this.isPassword = false,
    this.passwordVisibility = false,
    required this.valid,
  }) : super(key: key);

  final IconData icon;
  final String labelText;
  final String hintText;
  final TextEditingController? textEditingController;
  final TeacherEditProfileController controller;
  final bool isPassword;
  final bool passwordVisibility;
  final String? Function(String?) valid;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherEditProfileController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width * .9,
        child: TextFormField(
          validator: valid,
          obscureText: isPassword ? !passwordVisibility : false,
          controller: textEditingController,
          style: const TextStyle(
            fontFamily: "Manrope",
            fontSize: 16,
          ),
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            labelText: labelText,
            floatingLabelStyle: const TextStyle(
              fontFamily: "Manrope",
              color: AppColor.darkIndigo,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: "Manrope"),
            prefixIcon: Icon(
              icon,
              color: AppColor.darkIndigo,
              size: 22,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      !passwordVisibility
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      if (labelText == 'Current Password') {
                        controller.currentPasswordVisible.value =
                            !controller.currentPasswordVisible.value;
                      } else if (labelText == 'New Password') {
                        controller.newPasswordVisible.value =
                            !controller.newPasswordVisible.value;
                      } else if (labelText == 'Confirm Password') {
                        controller.confirmPasswordVisible.value =
                            !controller.confirmPasswordVisible.value;
                      }
                    },
                  )
                : const SizedBox(),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: AppColor.darkIndigo, width: 1.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: AppColor.darkIndigo, width: .8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    });
  }
}
