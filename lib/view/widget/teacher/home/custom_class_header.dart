import 'package:flutter/material.dart';

class CustomClassHeader extends StatelessWidget {
  const CustomClassHeader(
      {super.key,
      required this.classCode,
      required this.block,
      required this.semester,
      required this.year});
  final String classCode;
  final String block;
  final String semester;
  final String year;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: classCode,
                  style: const TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.teal)),
              TextSpan(
                  text: " / Block $block",
                  style: const TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black45)),
            ],
          ),
        ),
        Text("$year / Semester $semester",
            style: const TextStyle(
                fontFamily: "Manrope",
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.black45)),
      ],
    );
  }
}
