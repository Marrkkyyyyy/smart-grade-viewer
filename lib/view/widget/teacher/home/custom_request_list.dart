import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_request_page_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/data/model/class_request_model.dart';
import 'package:smart_grade_viewer/link_api.dart';

class CustomRequestList extends StatelessWidget {
  const CustomRequestList(
      {super.key, required this.controller, required this.classRequest});
  final TeacherRequestPageController controller;
  final ClassRequestModel classRequest;
  @override
  Widget build(BuildContext context) {
    String fullName = "${classRequest.lastName}, ${classRequest.firstName}";
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            border: const Border(
              left: BorderSide(color: AppColor.lightIndigo, width: 5.5),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.2,
                blurRadius: 3,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Container(
              margin: const EdgeInsets.only(left: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        classRequest.profile == "null"
                            ? const CircleAvatar(
                                foregroundColor: Colors.white,
                                radius: 25,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person),
                              )
                            : ClipOval(
                                child: CachedNetworkImage(
                                height: 50,
                                width: 50,
                                imageUrl:
                                    AppLink.userProfile + classRequest.profile!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.black26,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                              )),
                        const SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: "Manrope", fontSize: 16),
                              ),
                              Text(
                                classRequest.schoolID!,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Manrope",
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: controller.statusRequestNew ==
                                  StatusRequest.loading
                              ? () {}
                              : () {
                                  controller
                                      .rejectRequest(classRequest.requestID!);
                                },
                          child: const CircleAvatar(
                              radius: 20,
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(225, 244, 67, 54),
                              child: Icon(
                                Icons.close,
                                size: 18,
                              )),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: controller.statusRequestNew ==
                                  StatusRequest.loading
                              ? () {}
                              : () {
                                  controller.acceptRequest(
                                      classRequest.requestID!,
                                      classRequest.studentID!,
                                      classRequest.teacherClassID!);
                                },
                          child: const CircleAvatar(
                              radius: 20,
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(239, 76, 175, 79),
                              child: Icon(
                                Icons.check,
                                size: 18,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
