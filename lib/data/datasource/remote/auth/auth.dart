import 'package:smart_grade_viewer/core/class/crud.dart';
import 'package:smart_grade_viewer/link_api.dart';

class AuthData {
  Crud crud;
  AuthData(this.crud);

  changePassword(
    String emailAddress,
    String currentPassword,
    String newPassword,
  ) async {
    var response = await crud.postData(AppLink.changePassword, {
      "emailAddress": emailAddress,
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    });

    return response.fold((l) => l, (r) => r);
  }

  registerTeacher(
    String userType,
    String firstName,
    String lastName,
    String emailAddress,
  ) async {
    var response = await crud.postData(AppLink.register, {
      "userType": userType,
      "firstName": firstName,
      "lastName": lastName,
      "emailAddress": emailAddress,
    });

    return response.fold((l) => l, (r) => r);
  }

  registerStudent(
    String userType,
    String schoolID,
    String firstName,
    String middleName,
    String lastName,
    String emailAddress,
    String password,
  ) async {
    var response = await crud.postData(AppLink.register, {
      "userType": userType,
      "schoolID": schoolID,
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "emailAddress": emailAddress,
      "password": password,
    });

    return response.fold((l) => l, (r) => r);
  }

  login(
    String emailAddress,
    String password,
  ) async {
    var response = await crud.postData(AppLink.login, {
      "emailAddress": emailAddress,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }

  loginNewPassword(
    String teacherID,
    String password,
  ) async {
    var response = await crud.postData(AppLink.loginNewPassword, {
      "teacherID": teacherID,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
