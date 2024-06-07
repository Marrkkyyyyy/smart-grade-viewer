import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_evaluation_dashboard_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/evaluation_model.dart';
import 'package:intl/intl.dart';

class TeacherEvaluationDashboard extends StatelessWidget {
  const TeacherEvaluationDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherEvaluationDashboardController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: Text(
          "${controller.classData.code}",
          style: const TextStyle(fontFamily: "Manrope"),
        ),
        actions: [
          GetBuilder<TeacherEvaluationDashboardController>(
              builder: (controller) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(controller.evaluationList.length.toString(),
                  style: const TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 16,
                      fontWeight: FontWeight.w900)),
            ));
          })
        ],
        backgroundColor: Color(int.parse('0x${controller.classData.color}')),
      ),
      body: GetBuilder<TeacherEvaluationDashboardController>(
          builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top: 6),
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  controller.statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                  HandlingViewRequest(
                    statusRequest: controller.statusRequest,
                    widget: controller.evaluationList.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .3,
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
                                    "No Evalution Found",
                                    style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 18,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: List.generate(
                                controller.evaluationList.length, (index) {
                              EvaluationModel evaluation =
                                  controller.evaluationList[index];
                              String formattedDate =
                                  DateFormat('E, MMMM d, y hh:mma').format(
                                      DateTime.parse(evaluation.dateCreated!));
                              int num = index + 1;
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoute.teacherEvaluationDetails,
                                          arguments: {
                                            "evaluationData": evaluation,
                                            "classData": controller.classData,
                                            "index": num.toString()
                                          });
                                    },
                                    minLeadingWidth: 0,
                                    dense: true,
                                    leading: Text(
                                      "$num.",
                                      style: const TextStyle(
                                          fontFamily: "Manrope"),
                                    ),
                                    title: Text("Anonymous$num",
                                        style: const TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    subtitle: Text(formattedDate,
                                        style: const TextStyle(
                                            fontFamily: "Manrope")),
                                  ),
                                ),
                              );
                            }),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
