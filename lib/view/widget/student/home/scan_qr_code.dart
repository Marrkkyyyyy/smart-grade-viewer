import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_grade_viewer/view/widget/scanner_overlay.dart';

class ScanQRCode extends StatelessWidget {
  const ScanQRCode({super.key, required this.function});
  
  final Function(Barcode barcode, dynamic args) function;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 25, top: 16, right: 20),
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Place the QR Code in the area",
              style: TextStyle(fontSize: 16, fontFamily: "Manrope"),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 300,
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: Colors.blue,
                  borderWidth: 12,
                  cutOutHeight: 300,
                  cutOutWidth: 300,
                ),
              ),
              child: SizedBox(
                width: 280,
                child: MobileScanner(
                  allowDuplicates: false,
                  fit: BoxFit.cover,
                  onDetect: (barcode, args) {
                    function(barcode, args);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
