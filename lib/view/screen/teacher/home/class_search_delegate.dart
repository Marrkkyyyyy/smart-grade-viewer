import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_grade_viewer/core/class/handling_view_request.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/data/model/class_model.dart';

class SearchClass extends SearchDelegate<String> {
  final List<ClassModel> classList;
  final StatusRequest statusRequest;

  SearchClass(this.classList, this.statusRequest);
  @override
  String get searchFieldLabel => 'Search...';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColor.lightIndigo,
        ),
        textTheme: const TextTheme(
            headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ClassModel> filteredClasses = classList
        .where((element) => element.name!.toLowerCase().contains(query))
        .toList();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: filteredClasses.isEmpty
            ? Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .2,
                ),
                child: Center(
                  child: Column(
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
            : Column(
                children: [
                  statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                  HandlingViewRequest(
                    statusRequest: statusRequest,
                    widget: classList.isEmpty
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
                              children: List.generate(filteredClasses.length,
                                  (index) {
                                ClassModel classItem = filteredClasses[index];
                                return Container(
                                  padding: const EdgeInsets.all(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoute.teacherClassPage,
                                          arguments: {"classData": classItem});
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
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                  color: AppColor.darkIndigo,
                                                  width: 5.5),
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                            ),
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColor.lightIndigo,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(4),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    4)),
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 6),
                                                    child: Text(
                                                      "Block ${classItem.block}",
                                                      style: const TextStyle(
                                                        fontFamily: "Manrope",
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            classItem.name!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontFamily:
                                                                    'Manrope',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(int.parse(
                                                              '0x${classItem.color}')),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxWidth: 70,
                                                                  minWidth: 70),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Center(
                                                            child: Text(
                                                              classItem.code!,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Manrope",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
