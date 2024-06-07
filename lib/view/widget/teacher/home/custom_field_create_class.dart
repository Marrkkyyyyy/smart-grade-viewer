import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';

class CustomFieldCreateClass extends StatelessWidget {
  const CustomFieldCreateClass(
      {super.key,
      required this.labelText,
      this.controller,
      this.maxLength,
      this.hintText,
      this.textInputType,
      this.textInputFormatter,
      this.textCapitalization = TextCapitalization.words,
      this.autoFocus = false, required this.valid});
  final String labelText;
  final TextEditingController? controller;
  final int? maxLength;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputFormatter? textInputFormatter;
  final TextCapitalization? textCapitalization;
  final bool autoFocus;
  final String? Function(String?) valid;
  @override
  Widget build(BuildContext context) {
    return TextFormField(validator: valid,
      autofocus: autoFocus,
      textCapitalization: textCapitalization!,
      inputFormatters:
          textInputFormatter != null ? [textInputFormatter!] : null,
      keyboardType: textInputType,
      maxLength: maxLength,
      controller: controller,
      style: const TextStyle(fontFamily: "Manrope"),
      decoration: InputDecoration(
          counterText: "",
          floatingLabelStyle: const TextStyle(
              fontFamily: "Manrope",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.darkIndigo),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontFamily: "Manrope", fontSize: 16, color: Colors.black45),
          labelStyle: const TextStyle(fontFamily: "Manrope", fontSize: 18),
          isDense: true,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.darkIndigo),
          ),
          border: const UnderlineInputBorder()),
    );
  }
}
