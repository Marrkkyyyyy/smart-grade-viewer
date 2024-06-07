import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/controller/teacher/teacher_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/link_api.dart';
import 'package:smart_grade_viewer/view/widget/custom_drawer_item.dart';

class TeacherDrawer extends StatelessWidget {
  const TeacherDrawer({super.key, required this.controller});
  final TeacherDashboardController controller;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColor.lightIndigo),
            accountName: Text(
              "${controller.firstName!} ${controller.lastName!}",
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
              color: AppColor.extraLightIndigo,
              icon: Icons.person,
              text: "Profile",
              function: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoute.teacherProfile);
              }),
          CustomDrawerItem(
            color: AppColor.extraLightIndigo,
            icon: Icons.archive,
            text: "Archive",
            function: () {
              Navigator.of(context).pop();
              Get.toNamed(AppRoute.teacherArchive);
            },
          ),
          CustomDrawerItem(
              color: AppColor.extraLightIndigo,
              icon: Icons.star,
              text: "Evaluation",
              function: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoute.teacherEvaluation);
              }),
          CustomDrawerItem(
              color: AppColor.extraLightIndigo,
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
