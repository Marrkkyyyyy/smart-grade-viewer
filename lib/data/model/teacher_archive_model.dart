class TeacherArchiveModel {
  String? year;
  String? isArchived;
  List<TeacherArchiveItem> classes;

  TeacherArchiveModel({
    this.year,
    this.isArchived,
    required this.classes,
  });

  factory TeacherArchiveModel.fromJson(Map<String, dynamic> json) {
    List<TeacherArchiveItem> classesList = [];
    if (json['class'] != null) {
      classesList = List<TeacherArchiveItem>.from(
          json['class'].map((x) => TeacherArchiveItem.fromJson(x)));
    }
    return TeacherArchiveModel(
      year: json['year'].toString(),
      isArchived: json['isArchived'].toString(),
      classes: classesList,
    );
  }
}

class TeacherArchiveItem {
  String? teacherClassID;
  String? teacherID;
  String? classID;
  String? firstName;
  String? lastName;
  String? profile;
  String? name;
  String? code;
  String? linkCode;
  String? block;
  String? semester;
  String? color;
  String? dateCreated;

  TeacherArchiveItem({
    this.teacherClassID,
    this.teacherID,
    this.classID,
    this.firstName,
    this.lastName,
    this.profile,
    this.name,
    this.code,
    this.linkCode,
    this.block,
    this.semester,
    this.color,
    this.dateCreated,
  });

  factory TeacherArchiveItem.fromJson(Map<String, dynamic> json) {
    return TeacherArchiveItem(
      teacherClassID: json['teacherClassID'].toString(),
      teacherID: json['teacherID'].toString(),
      classID: json['classID'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      profile: json['profile'].toString(),
      name: json['name'].toString(),
      code: json['code'].toString(),
      linkCode: json['linkCode'].toString(),
      block: json['block'].toString(),
      semester: json['semester'].toString(),
      color: json['color'].toString(),
      dateCreated: json['date_created'].toString(),
    );
  }
}
