import 'package:flutter/material.dart';

class CustomClassName extends StatelessWidget {
  const CustomClassName({super.key, required this.className});
  final String className;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        className,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: "Manrope",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87),
      ),
    );
  }
}
