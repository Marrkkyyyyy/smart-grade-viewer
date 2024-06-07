import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';

class CustomRequestShimmer extends StatelessWidget {
  const CustomRequestShimmer({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          width: size.width * 1,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                      child: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(50, 0, 0, 0),
                    highlightColor: const Color.fromARGB(176, 255, 255, 255),
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromARGB(70, 0, 0, 0),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(50, 0, 0, 0),
                        highlightColor:
                            const Color.fromARGB(176, 255, 255, 255),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: Container(
                            color: const Color.fromARGB(70, 0, 0, 0),
                            height: size.height * .016,
                            width: size.width * .5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(50, 0, 0, 0),
                        highlightColor:
                            const Color.fromARGB(176, 255, 255, 255),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: Container(
                            color: const Color.fromARGB(70, 0, 0, 0),
                            height: size.height * .016,
                            width: size.width * .25,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
