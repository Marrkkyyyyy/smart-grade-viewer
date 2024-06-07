import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonRankings extends StatelessWidget {
  const CustomButtonRankings(
      {super.key,
      required this.function,
      required this.icon,
      required this.text});
  final Function function;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: const Color.fromARGB(255, 255, 196, 0),
              size: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black54,
                  fontFamily: "Manrope",
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}
