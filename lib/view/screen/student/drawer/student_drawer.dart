import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/student/student_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/link_api.dart';
import 'package:smart_grade_viewer/view/widget/custom_drawer_item.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentDashboardController>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColor.orange),
            accountName: Text(
              "${controller.firstName} ${controller.lastName}",
              style: const TextStyle(fontFamily: "Manrope", fontSize: 16),
            ),
            accountEmail: Text(
              controller.emailAddress!,
              style: const TextStyle(fontFamily: "Manrope", fontSize: 14),
            ),
            currentAccountPicture: controller.profile != "null"
                ? ClipOval(
                    child: CachedNetworkImage(
                    height: 80,
                    width: 80,
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
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 42,
                    ),
                  ),
          ),
          CustomDrawerItem(
              color: AppColor.lightBlue,
              icon: Icons.person,
              text: "Profile",
              function: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoute.studentProfile);
              }),
          CustomDrawerItem(
              color: AppColor.lightBlue,
              icon: Icons.auto_graph_rounded,
              text: "Overall Grades",
              function: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoute.overallGrades);
              }),
          CustomDrawerItem(
              color: AppColor.lightBlue,
              icon: Icons.archive,
              text: "Archive",
              function: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoute.studentArchive);
              }),
          CustomDrawerItem(
              color: AppColor.lightBlue,
              icon: Icons.logout,
              text: "Logout",
              function: () {
                controller.logout();
              }),
        ],
      ),
    );
  }
}
