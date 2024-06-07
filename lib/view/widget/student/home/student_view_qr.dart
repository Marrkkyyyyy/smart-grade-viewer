import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomStudentViewQR extends StatelessWidget {
  const CustomStudentViewQR({super.key, required this.classCode});
  final String classCode;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImage(
              data: classCode,
              version: QrVersions.auto,
              size: 250,
            ),
            const SizedBox(
              height: 6,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontFamily: "Manrope",
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
                text: 'Class Code: ',
                children: [
                  TextSpan(
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal),
                    text: classCode,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * .55, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                backgroundColor: Colors.blue.shade600,
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: classCode));
                Navigator.of(context).pop();
              },
              child: const Text(
                "Copy",
                style: TextStyle(
                    fontFamily: "Manrope", fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
