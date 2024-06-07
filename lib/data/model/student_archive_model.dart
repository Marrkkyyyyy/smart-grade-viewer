class StudentArchiveModel {
  String? year;
  String? studentID;
  String? isArchived;
  String? studentFirstName;
  String? studentLastName;
  String? studentEmailAddress;
  String? teacherProfile;
  List<StudentArchiveItem> classes;

  StudentArchiveModel({
    this.year,
    this.studentID,
    this.isArchived,
    this.studentFirstName,
    this.studentLastName,
    this.studentEmailAddress,
    this.teacherProfile,
    required this.classes,
  });

  factory StudentArchiveModel.fromJson(Map<String, dynamic> json) {
    List<StudentArchiveItem> classesList = [];
    if (json['class'] != null) {
      classesList =
          List<StudentArchiveItem>.from(json['class'].map((x) => StudentArchiveItem.fromJson(x)));
    }
    return StudentArchiveModel(
      year: json['year'].toString(),
      studentID: json['studentID'].toString(),
      isArchived: json['isArchived'].toString(),
      studentFirstName: json['studentFirstName'].toString(),
      studentLastName: json['studentLastName'].toString(),
      studentEmailAddress: json['studentEmailAddress'].toString(),
      teacherProfile: json['teacherProfile'].toString(),
      classes: classesList,
    );
  }
}

class StudentArchiveItem {
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

  StudentArchiveItem({
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

  factory StudentArchiveItem.fromJson(Map<String, dynamic> json) {
    return StudentArchiveItem(
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
