import 'package:smart_grade_viewer/core/class/crud.dart';
import 'package:smart_grade_viewer/link_api.dart';

class AdminData {
  Crud crud;
  AdminData(this.crud);

  fetchTeacher() async {
    var response = await crud.postData(AppLink.fetchTeacer, {});
    return response.fold((l) => l, (r) => r);
  }
}
