import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/teacher/drawer/teacher_evaluation_details_controller.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';

class TeacherEvaluationDetails extends StatelessWidget {
  const TeacherEvaluationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherEvaluationDetailsController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        title: GetBuilder<TeacherEvaluationDetailsController>(
            builder: (controller) {
          return Text(
            "Anonymous${controller.index}",
            style: const TextStyle(fontFamily: "Manrope"),
          );
        }),
        backgroundColor: controller.classData.color == "" 
            ? AppColor.skyBlue
            : Color(int.parse('0x${controller.classData.color}')),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(controller.evaluationQuestions.length,
                    (index) {
                  int num = index + 1;
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: 12, left: 16, right: 12, bottom: 8),
                      minLeadingWidth: 0,
                      leading: Text(
                        "$num.",
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      title: Text(
                        controller.evaluationQuestions[index],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope",
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(controller.evaluationAnswers[index])
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const Text(
                "Comment",
                style: TextStyle(fontFamily: "Manrope", fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * .2),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(controller.evaluationData.comment!,
                    style:
                        const TextStyle(fontFamily: "Manrope", fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
