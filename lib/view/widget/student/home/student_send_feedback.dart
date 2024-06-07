import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/student/student_class_page_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/data/model/feedback_model.dart';

class StudentSendFeedback extends StatelessWidget {
  const StudentSendFeedback(
      {super.key, required this.controller, required this.fullName});
  final StudentClassPageController controller;
  final String fullName;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentClassPageController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 15),
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 224, 224, 224),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45),
                    text: '',
                    children: [
                      const TextSpan(
                        text: "to: ",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      TextSpan(
                        text: fullName,
                        style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColor.darkBlue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                const SizedBox(
                  height: 6,
                ),
                controller.statusRequestFeedback != StatusRequest.success
                    ? const SizedBox()
                    : const Text(
                        "Feedback",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                const SizedBox(
                  height: 6,
                ),
                controller.statusRequestFeedback != StatusRequest.success
                    ? const SizedBox()
                    : controller.feedbackList.isEmpty
                        ? Container(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: const Center(
                              child: Text(
                                "No feedback yet ",
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            ),
                          )
                        : const SizedBox(),
                controller.statusRequestFeedback != StatusRequest.success
                    ? Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(AppImageASset.nomessage,
                                  width: 200, repeat: true),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(controller.feedbackList.length,
                            (index) {
                          FeedbackModel feedback =
                              controller.feedbackList[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment:
                                  feedback.senderID == controller.studentID
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: feedback.senderID ==
                                            controller.studentID
                                        ? AppColor.skyBlue
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(8)),
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * .8),
                                child: Text(
                                  feedback.message!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                controller.statusRequestFeedback != StatusRequest.success
                    ? const SizedBox()
                    : controller.feedbackList.isNotEmpty
                        ? Column(
                            children: const [
                              Divider(
                                thickness: 1,
                              ),
                              Text(
                                "You've already responded",
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (controller.isFocused.value)
                                      Container(
                                          padding: const EdgeInsets.only(
                                              right: 6, bottom: 4),
                                          child: Obx(() {
                                            return Text(
                                              "${controller.feedbackCharacterCount.value} / 150",
                                              style: const TextStyle(
                                                  fontFamily: "Manrope",
                                                  fontSize: 12),
                                            );
                                          })),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontFamily: "Manrope",
                                      ),
                                      onChanged: (value) {
                                        controller.updateCharacterCount();
                                      },
                                      controller: controller.feedbackController,
                                      focusNode: controller.focusNode,
                                      maxLength: 150,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        hintStyle: TextStyle(
                                          fontFamily: "Manrope",
                                        ),
                                        labelStyle: TextStyle(
                                          fontFamily: "Manrope",
                                        ),
                                        counterText: "",
                                        isDense: true,
                                        hintText: "Type a message...",
                                        labelText: 'Message',
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: controller.statusRequestSend ==
                                        StatusRequest.loading
                                    ? () {}
                                    : () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        controller.sendFeedback();
                                      },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  color: Colors.transparent,
                                  height: 50,
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                ),
                              )
                            ],
                          )
              ],
            ),
          ),
        ),
      );
    });
  }
}
