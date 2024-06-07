import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_dashboard_controller.dart';

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({super.key, required this.controller});
  final TeacherDashboardController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 50),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .37,
          child: BlockPicker(
            availableColors: const [
              Colors.red,
              Colors.pink,
              Colors.purple,
              Colors.indigo,
              Colors.blue,
              Colors.cyan,
              Colors.teal,
              Colors.green,
              Colors.lime,
              Colors.amber,
              Colors.orange,
              Colors.brown,
              Colors.grey,
              Colors.blueGrey,
            ],
            pickerColor: controller.containerColor.value,
            onColorChanged: (Color color) {
              controller.containerColor.value = color;
              Get.back();
            },
          ),
        ));
  }
}
