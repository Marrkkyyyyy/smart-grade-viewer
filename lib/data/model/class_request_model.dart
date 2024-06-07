class ClassRequestModel {
  String? requestID;
  String? studentID;
  String? teacherClassID;
  String? teacherID;
  String? classID;
  String? schoolID;
  String? firstName;
  String? lastName;
  String? middleName;
  String? emailAddress;
  String? profile;
  String? name;
  String? code;
  String? linkCode;

  ClassRequestModel(
      {this.requestID,
      this.studentID,
      this.teacherClassID,
      this.teacherID,
      this.classID,
      this.schoolID,
      this.firstName,
      this.lastName,
      this.middleName,
      this.emailAddress,
      this.profile,
      this.name,
      this.code,
      this.linkCode});

  ClassRequestModel.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'].toString();
    studentID = json['studentID'].toString();
    teacherClassID = json['teacherClassID'].toString();
    teacherID = json['teacherID'].toString();
    classID = json['classID'].toString();
    schoolID = json['schoolID'].toString();
    firstName = json['firstName'].toString();
    lastName = json['lastName'].toString();
    middleName = json['middleName'].toString();
    emailAddress = json['emailAddress'].toString();
    profile = json['profile'].toString();
    name = json['name'].toString();
    code = json['code'].toString();
    linkCode = json['linkCode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestID'] = requestID;
    data['studentID'] = studentID;
    data['teacherClassID'] = teacherClassID;
    data['teacherID'] = teacherID;
    data['classID'] = classID;
    data['schoolID'] = schoolID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['emailAddress'] = emailAddress;
    data['profile'] = profile;
    data['name'] = name;
    data['code'] = code;
    data['linkCode'] = linkCode;
    return data;
  }
}
