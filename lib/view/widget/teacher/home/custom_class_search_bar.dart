import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_class_page_controller.dart';

class CustomClassSearchBar extends StatelessWidget {
  const CustomClassSearchBar({super.key, required this.controller});
  final TeacherClassPageController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              spreadRadius: .4,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            controller.searchIconColor.value =
                hasFocus ? Colors.teal : Colors.grey;
          },
          child: TextFormField(
            controller: controller.searchController,
            style: const TextStyle(
              fontFamily: "Manrope",
              fontSize: 16,
            ),
            onChanged: (value) {
              controller.search(value);
            },
            decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                hintText: "Search",
                hintStyle: const TextStyle(fontFamily: "Manrope"),
                prefixIcon: Icon(
                  Icons.search,
                  size: 22,
                  color: controller.searchIconColor.value,
                ),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: .5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
        ),
      );
    });
  }
}
