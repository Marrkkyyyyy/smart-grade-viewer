import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/student/student_profile_controller.dart.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/link_api.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentProfileController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<StudentProfileController>(builder: (controller) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 6),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.transparent,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.profile != "null"
                      ? ClipOval(
                          child: CachedNetworkImage(
                          height: 140,
                          width: 140,
                          imageUrl: AppLink.userProfile + controller.profile!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.black26,
                            highlightColor: Colors.white,
                            child: Container(
                              color: Colors.black26,
                            ),
                          ),
                        ))
                      : const CircleAvatar(
                          radius: 70,
                          backgroundColor: Color.fromARGB(50, 0, 0, 0),
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${controller.firstName} ${controller.lastName}",
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    controller.emailAddress!,
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    controller.schoolID!,
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.studentEditProfile);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      decoration: BoxDecoration(
                          color: AppColor.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
