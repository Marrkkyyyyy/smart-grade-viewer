import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_grade_viewer/controller/student/student_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/view/widget/student/home/scan_qr_code.dart';

class StudentJoinClass extends StatelessWidget {
  const StudentJoinClass({super.key, required this.controller});
  final StudentDashboardController controller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentDashboardController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Dialog(
          child: Form(
            key: controller.formstate,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Join Class",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "Manrope",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter required field";
                        } else {
                          return null;
                        }
                      },
                      controller: controller.classCodeController,
                      autofocus: true,
                      maxLength: 8,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ScanQRCode(
                                      function: (Barcode barcode, args) {
                                        Get.back(result: true);
                                        controller.classCodeController.text =
                                            barcode.rawValue.toString();
                                      },
                                    );
                                  }).then((value) {
                                if (value == true) {
                                  Navigator.of(context).pop();
                                  controller.joinClass();
                                  controller.classCodeController.clear();
                                }
                              });
                            },
                            child: const Icon(
                              Icons.qr_code_scanner_rounded,
                              size: 24,
                            ),
                          ),
                          counterText: "",
                          isDense: true,
                          labelText: "Class Code",
                          hintText: "Enter class code",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 196, 196, 196),
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 16,
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: controller.statusRequestJoin ==
                                  StatusRequest.loading
                              ? () {}
                              : () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  controller.validateInput();
                                },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.darkBlue,
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 30),
                            child: const Center(
                              child: Text(
                                "Join",
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
