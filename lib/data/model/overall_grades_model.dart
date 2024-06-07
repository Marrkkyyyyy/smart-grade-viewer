class OverallGradesModel {
  String? year;
  String? semester;
  List<ClassItem> classes;

  OverallGradesModel({
    this.year,
    this.semester,
    required this.classes,
  });

  factory OverallGradesModel.fromJson(Map<String, dynamic> json) {
    List<ClassItem> classesList = [];
    if (json['class'] != null) {
      classesList =
          List<ClassItem>.from(json['class'].map((x) => ClassItem.fromJson(x)));
    }
    return OverallGradesModel(
      year: json['year'].toString(),
      semester: json['semester'].toString(),
      classes: classesList,
    );
  }
}

class ClassItem {
  String? isArchived;
  String? studentFirstName;
  String? studentLastName;
  String? studentEmailAddress;
  String? teacherProfile;
  String? classroomID;
  String? teacherClassID;
  String? grade;
  String? studentMiddleName;
  String? firstName;
  String? lastName;
  String? teacherID;
  String? classID;
  String? name;
  String? code;
  String? linkCode;
  String? block;
  String? semester;
  String? color;
  String? dateCreated;

  ClassItem({
    this.isArchived,
    this.studentFirstName,
    this.studentLastName,
    this.studentEmailAddress,
    this.teacherProfile,
    this.classroomID,
    this.teacherClassID,
    this.grade,
    this.studentMiddleName,
    this.firstName,
    this.lastName,
    this.teacherID,
    this.classID,
    this.name,
    this.code,
    this.linkCode,
    this.block,
    this.semester,
    this.color,
    this.dateCreated,
  });

  factory ClassItem.fromJson(Map<String, dynamic> json) {
    return ClassItem(
      isArchived: json['isArchived'].toString(),
      studentFirstName: json['studentFirstName'].toString(),
      studentLastName: json['studentLastName'].toString(),
      studentEmailAddress: json['studentEmailAddress'].toString(),
      teacherProfile: json['teacherProfile'].toString(),
      classroomID: json['classroomID'].toString(),
      teacherClassID: json['teacherClassID'].toString(),
      grade: json['grade'].toString(),
      studentMiddleName: json['studentMiddleName'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      teacherID: json['teacherID'].toString(),
      classID: json['classID'].toString(),
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
