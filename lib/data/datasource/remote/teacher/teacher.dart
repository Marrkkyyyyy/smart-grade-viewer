import 'dart:io';

import 'package:smart_grade_viewer/core/class/crud.dart';
import 'package:smart_grade_viewer/link_api.dart';

class TeacherData {
  Crud crud;
  TeacherData(this.crud);

  fetchEvaluation(
    String? teacherClassID,
  ) async {
    var response = await crud.postData(AppLink.fetchEvaluation, {
      "teacherClassID": teacherClassID,
    });

    return response.fold((l) => l, (r) => r);
  }

  teacherArchive(
    String classID,
    String isArchived,
  ) async {
    var response = await crud.postData(AppLink.teacherArchive, {
      "classID": classID,
      "isArchived": isArchived,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchArchiveClass(
    String teacherID,
  ) async {
    var response = await crud.postData(AppLink.fetchTeacherArchive, {
      "teacherID": teacherID,
    });

    return response.fold((l) => l, (r) => r);
  }

  editProfile(
    File? image,
    String teacherID,
    String firstName,
    String lastName,
  ) async {
    if (image == null) {
      var response = await crud.postData(AppLink.teacherEditProfile, {
        "teacherID": teacherID,
        "firstName": firstName,
        "lastName": lastName,
      });
      return response.fold((l) => l, (r) => r);
    } else {
      var response = await crud.postImageData(AppLink.teacherEditProfile, {
        "image": image,
        "teacherID": teacherID,
        "firstName": firstName,
        "lastName": lastName,
      });
      return response.fold((l) => l, (r) => r);
    }
  }

  unenrollStudent(
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

  replyFeedback(
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

  createNewClass(
    String teacherID,
    String name,
    String code,
    String block,
    String semester,
    String color,
  ) async {
    var response = await crud.postData(AppLink.createNewClass, {
      "teacherID": teacherID,
      "name": name,
      "code": code,
      "block": block,
      "semester": semester,
      "color": color.toString(),
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchTeacherClass(
    String? teacherID,
  ) async {
    var response = await crud.postData(AppLink.fetchTeacherClass, {
      "teacherID": teacherID,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchTeacherStudent(
    String? classID,
  ) async {
    var response = await crud.postData(AppLink.fetchTeacherStudent, {
      "classID": classID,
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchRequests(
    String? classID,
  ) async {
    var response = await crud.postData(AppLink.fetchRequests, {
      "classID": classID,
    });

    return response.fold((l) => l, (r) => r);
  }

  rejectRequest(
    String? requestID,
  ) async {
    var response = await crud.postData(AppLink.rejectRequest, {
      "requestID": requestID,
    });

    return response.fold((l) => l, (r) => r);
  }

  acceptRequest(
    String? requestID,
    String? studentID,
    String? teacherClassID,
  ) async {
    var response = await crud.postData(AppLink.acceptRequest, {
      "requestID": requestID,
      "studentID": studentID,
      "teacherClassID": teacherClassID,
    });

    return response.fold((l) => l, (r) => r);
  }

  submitGrade(
    String? classroomID,
    String? grade,
  ) async {
    var response = await crud.postData(AppLink.submitGrade, {
      "classroomID": classroomID,
      "grade": grade,
    });

    return response.fold((l) => l, (r) => r);
  }
}
