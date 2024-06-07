import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/student/student_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';
import 'package:smart_grade_viewer/link_api.dart';

class CustomClassList extends StatelessWidget {
  const CustomClassList(
      {super.key, required this.classItem, required this.controller});
  final StudentClassModel classItem;
  final StudentDashboardController controller;
  @override
  Widget build(BuildContext context) {
    String fullName = "${classItem.lastName}, ${classItem.firstName}";
    return Container(
      margin: const EdgeInsets.all(4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed:
                  controller.statusRequestArchive == StatusRequest.loading
                      ? (context) {}
                      : (context) {
                          controller.archiveClass(classItem.classroomID!);
                        },
              backgroundColor: const Color(0xff8394FF),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: "Archive",
            ),
            SlidableAction(
              onPressed: controller.statusRequestDelete == StatusRequest.loading
                  ? (context) {}
                  : (context) {
                      controller.deleteClass(classItem.classroomID!,
                          controller.studentID!, classItem.teacherClassID!);
                    },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Delete",
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.studentClassPage,
                arguments: {"classItem": classItem});
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: classItem.grade == "null"
                            ? AppColor.darkBlue
                            : double.parse(classItem.grade!) >= 2 &&
                                    double.parse(classItem.grade!) <= 3
                                ? Colors.orange
                                : double.parse(classItem.grade!) > 3
                                    ? Colors.red
                                    : Colors.teal,
                        width: 5.5),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 6,
                    bottom: 6,
                    left: 6,
                  ),
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          classItem.teacherProfile == "null"
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
                                  imageUrl: AppLink.userProfile +
                                      classItem.teacherProfile!,
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
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(classItem.name!,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'Manrope',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 6),
                                decoration: BoxDecoration(
                                  color:
                                      Color(int.parse('0x${classItem.color}')),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  child: Text(
                                    classItem.code!,
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  "Semester ${classItem.semester}",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Manrope',
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Text(fullName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Manrope',
                                    fontSize: 14)),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
