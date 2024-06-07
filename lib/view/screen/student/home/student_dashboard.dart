import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/student/student_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/data/model/student_class_model.dart';
import 'package:smart_grade_viewer/view/screen/student/drawer/student_drawer.dart';
import 'package:smart_grade_viewer/view/widget/student/home/custom_student_class_list.dart';
import 'package:smart_grade_viewer/view/widget/student/home/student_join_class.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentDashboardController());
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color.fromARGB(245, 255, 255, 255),
      drawer: const StudentDrawer(),
      body: GetBuilder<StudentDashboardController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColor.orange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    height: Get.width * .3,
                    width: Get.width,
                    child: SafeArea(
                        child: Stack(children: [
                      IconButton(
                          onPressed: () {
                            controller.scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                          )),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StudentJoinClass(
                                            controller: controller);
                                      });
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 12,
                          child: Text("Welcome, ${controller.firstName}",
                              style: const TextStyle(
                                  fontFamily: "Manrope",
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600)))
                    ])),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6, top: 4),
                    child: Row(
                      children: const [
                        Text(
                          "Classes",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                  controller.statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                  HandlingViewRequest(
                    statusRequest: controller.statusRequest,
                    widget: controller.classList.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .25,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    AppImageASset.empty,
                                    repeat: false,
                                    width: 150,
                                  ),
                                  const Text(
                                    "No Class Found",
                                    style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 18,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8),
                            child: Column(
                              children: List.generate(
                                  controller.classList.length, (index) {
                                StudentClassModel classItem =
                                    controller.classList[index];
                                return CustomClassList(
                                  classItem: classItem,
                                  controller: controller,
                                );
                              }),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
