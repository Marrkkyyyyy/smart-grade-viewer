class StudentClassModel {
  String? classroomID;
  String? studentID;
  String? teacherClassID;
  String? isArchived;
  String? grade;
  String? studentFirstName;
  String? studentLastName;
  String? studentMiddleName;
  String? studentEmailAddress;
  String? firstName;
  String? lastName;
  String? teacherProfile;
  String? studentProfile;
  String? teacherID;
  String? classID;
  String? name;
  String? code;
  String? linkCode;
  String? block;
  String? semester;
  String? color;
  String? dateCreated;

  StudentClassModel(
      {this.classroomID,
      this.studentID,
      this.teacherClassID,
      this.isArchived,
      this.grade,
      this.studentFirstName,
      this.studentLastName,
      this.studentMiddleName,
      this.studentEmailAddress,
      this.firstName,
      this.lastName,
      this.teacherProfile,
      this.studentProfile,
      this.teacherID,
      this.classID,
      this.name,
      this.code,
      this.linkCode,
      this.block,
      this.semester,
      this.color,
      this.dateCreated});

  StudentClassModel.fromJson(Map<String, dynamic> json) {
    classroomID = json['classroomID'].toString();
    studentID = json['studentID'].toString();
    teacherClassID = json['teacherClassID'].toString();
    isArchived = json['isArchived'].toString();
    grade = json['grade'].toString();
    studentFirstName = json['studentFirstName'].toString();
    studentLastName = json['studentLastName'].toString();
    studentMiddleName = json['studentMiddleName'].toString();
    studentEmailAddress = json['studentEmailAddress'].toString();
    firstName = json['firstName'].toString();
    lastName = json['lastName'].toString();
    teacherProfile = json['teacherProfile'].toString();
    studentProfile = json['studentProfile'].toString();
    teacherID = json['teacherID'].toString();
    classID = json['classID'].toString();
    name = json['name'].toString();
    code = json['code'].toString();
    linkCode = json['linkCode'].toString();
    block = json['block'].toString();
    semester = json['semester'].toString();
    color = json['color'].toString();
    dateCreated = json['date_created'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['classroomID'] = classroomID;
    data['studentID'] = studentID;
    data['teacherClassID'] = teacherClassID;
    data['isArchived'] = isArchived;
    data['grade'] = grade;
    data['studentFirstName'] = studentFirstName;
    data['studentLastName'] = studentLastName;
    data['studentMiddleName'] = studentMiddleName;
    data['studentEmailAddress'] = studentEmailAddress;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['teacherProfile'] = teacherProfile;
    data['studentProfile'] = studentProfile;
    data['teacherID'] = teacherID;
    data['classID'] = classID;
    data['name'] = name;
    data['code'] = code;
    data['linkCode'] = linkCode;
    data['block'] = block;
    data['semester'] = semester;
    data['color'] = color;
    data['date_created'] = dateCreated;
    return data;
  }
}
