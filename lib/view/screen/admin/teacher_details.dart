import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/controller/admin/teacher_details_controller.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/evaluation_model.dart';

class TeacherDetails extends StatelessWidget {
  const TeacherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherDetailsController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: const Text(
          "Evaluation",
          style: TextStyle(fontFamily: "Manrope"),
        ),
        backgroundColor: AppColor.skyBlue,
      ),
      body: GetBuilder<TeacherDetailsController>(builder: (controller) {
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
