import 'dart:convert';
import 'dart:io';

import 'package:smart_grade_viewer/core/class/crud.dart';
import 'package:smart_grade_viewer/link_api.dart';

class StudentData {
  Crud crud;
  StudentData(this.crud);


    fetchOverallGrades(
    String studentID,
  ) async {
    var response = await crud.postData(AppLink.fetchOverallGrades, {
      "studentID": studentID,
    });

    return response.fold((l) => l, (r) => r);
  }

  evaluate(
    String? studentID,
    String? teacherClassID,
    List<String> evaluation,
    String? comment,
  ) async {
    var response = await crud.postData(AppLink.studentEvaluate, {
      "studentID": studentID,
      "teacherClassID": teacherClassID,
      "evaluation": json.encode(evaluation),
      "comment": comment,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteClass(
    String? classroomID,
    String? studentID,
    String? teacherClassID,
  ) async {
    var response = await crud.postData(AppLink.unenrollStudent, {
      "classroomID": classroomID,
      "studentID": studentID,
      "teacherClassID": teacherClassID,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchArchiveClass(
    String studentID,
  ) async {
    var response = await crud.postData(AppLink.fetchStudentArchive, {
      "studentID": studentID,
    });

    return response.fold((l) => l, (r) => r);
  }

  editProfile(
    File? image,
    String studentID,
    String firstName,
    String lastName,
    String emailAddress,
  ) async {
    if (image == null) {
      var response = await crud.postData(AppLink.editProfile, {
        "studentID": studentID,
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
      });
      return response.fold((l) => l, (r) => r);
    } else {
      var response = await crud.postImageData(AppLink.editProfile, {
        "image": image,
        "studentID": studentID,
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
      });
      return response.fold((l) => l, (r) => r);
    }
  }

  sendFeedback(
    String studentID,
    String teacherClassID,
    String senderID,
    String message,
  ) async {
    var response = await crud.postData(AppLink.sendFeedback, {
      "studentID": studentID,
      "teacherClassID": teacherClassID,
      "senderID": senderID,
      "message": message,
    });

    return response.fold((l) => l, (r) => r);
  }

  joinClass(
    String studentID,
    String classCode,
  ) async {
    var response = await crud.postData(AppLink.joinClass, {
      "studentID": studentID,
      "classCode": classCode,
    });

    return response.fold((l) => l, (r) => r);
  }

  studentArchive(
    String classroomID,
    String isArchived,
  ) async {
    var response = await crud.postData(AppLink.studentArchive, {
      "classroomID": classroomID,
      "isArchived": isArchived,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchStudentClass(
    String studentID,
  ) async {
    var response = await crud.postData(AppLink.fetchStudentClass, {
      "studentID": studentID,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchStudent(
    String classID,
    String studentID,
    String teacherClassID,
  ) async {
    var response = await crud.postData(AppLink.fetchStudent, {
      "classID": classID,
      "studentID": studentID,
      "teacherClassID": teacherClassID,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchFeedback(
    String studentID,
    String teacherClassID,
  ) async {
    var response = await crud.postData(AppLink.fetchFeedback, {
      "studentID": studentID,
      "teacherClassID": teacherClassID,
    });

    return response.fold((l) => l, (r) => r);
  }
}
