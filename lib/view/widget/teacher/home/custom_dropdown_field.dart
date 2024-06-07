import 'package:flutter/material.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField(
      {super.key,
      required this.labelText,
      required this.items,
      required this.controller});
  final String labelText;
  final List items;
  final TeacherDashboardController controller;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: (val) {
        if (val == null) {
          return "Enter required field";
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
          fontFamily: "Manrope",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColor.darkIndigo,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: "Manrope",
          fontSize: 18,
        ),
        isDense: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.darkIndigo),
        ),
        border: const UnderlineInputBorder(),
      ),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
                fontFamily: "Manrope", color: Colors.black87, fontSize: 16),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        controller.semester = newValue;
      },
      style: const TextStyle(fontFamily: "Manrope"),
    );
  }
}
