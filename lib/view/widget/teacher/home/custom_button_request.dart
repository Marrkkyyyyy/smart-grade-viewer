import 'package:flutter/material.dart';

class CustomButtonRequest extends StatelessWidget {
  const CustomButtonRequest(
      {super.key,
      required this.function,
      required this.text,
      required this.icon});
  final Function function;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: "Manrope",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
