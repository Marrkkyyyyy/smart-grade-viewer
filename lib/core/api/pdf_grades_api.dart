import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:smart_grade_viewer/core/api/pdf_api.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/data/model/teacher_student_model.dart';

class PdfGradesApi {
  static Future<File> generate(
      List<TeacherStudentModel> studentList, String className) async {
    final pdf = Document();

    final headerCICT = await loadCICTImage();
    final headerSEAIT = await loadSEAITImage();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (Context context) {
          return _buildHeader(headerCICT, headerSEAIT);
        },
        build: (context) => [
          pw.Center(
              child: Text(className,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14))),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text("Students"),
                pw.Text("Grades"),
              ]),
          pw.Divider(
              color: PdfColor.fromHex("#000000"),
              thickness: .5,
              height: PdfPageFormat.inch * .4),
          pw.Column(
              children: List.generate(studentList.length, (index) {
            TeacherStudentModel student = studentList[index];
            String fullName = "${student.lastName}, ${student.firstName}";
            return pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      Text(fullName),
                      student.grade == "null"
                          ? Text("N/A")
                          : Text(student.grade!)
                    ]));
          }))
        ],
      ),
    );

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static pw.Widget _buildHeader(pw.Widget headerCICT, pw.Widget headerSEAIT) {
    return pw.Column(children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          headerCICT,
          pw.Column(
            children: [
              pw.Text("South East Asian Institute of Technology, Inc.",
                  style: pw.TextStyle(
                      fontSize: 14, color: PdfColor.fromHex("#8fce00"))),
              pw.Text("COLLEGE OF INFORMATION AND COMMUNICATION \nTECHNOLOGY.",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 10, color: PdfColor.fromHex("#FF8503"))),
              pw.Text(
                  "National Highway, Crossing Rubber, Tupi 9505, South Cotabato",
                  style: const pw.TextStyle(fontSize: 10)),
            ],
          ),
          headerSEAIT,
        ],
      ),
      pw.Divider(
          color: PdfColor.fromHex("#000000"),
          thickness: .5,
          height: PdfPageFormat.inch * .4)
    ]);
  }

  static Future<pw.Image> loadCICTImage() async {
    final ByteData data = await rootBundle.load(AppImageASset.cictLogo);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.Image(pw.MemoryImage(bytes),
        width: PdfPageFormat.inch * 0.79, height: PdfPageFormat.inch * 0.74);
  }

  static Future<pw.Image> loadSEAITImage() async {
    final ByteData data = await rootBundle.load(AppImageASset.schoolLogo);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.Image(pw.MemoryImage(bytes),
        width: PdfPageFormat.inch * 0.79, height: PdfPageFormat.inch * 0.74);
  }
}
