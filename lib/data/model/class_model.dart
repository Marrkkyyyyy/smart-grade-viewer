class ClassModel {
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
  String? isArchived;

  ClassModel(
      {this.teacherClassID,
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
      this.isArchived});

  ClassModel.fromJson(Map<String, dynamic> json) {
    teacherClassID = json['teacherClassID'].toString();
    teacherID = json['teacherID'].toString();
    classID = json['classID'].toString();
    firstName = json['firstName'].toString();
    lastName = json['lastName'].toString();
    profile = json['profile'].toString();
    name = json['name'].toString();
    code = json['code'].toString();
    linkCode = json['linkCode'].toString();
    block = json['block'].toString();
    semester = json['semester'].toString();
    color = json['color'].toString();
    dateCreated = json['date_created'].toString();
    isArchived = json['isArchived'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacherClassID'] = teacherClassID;
    data['teacherID'] = teacherID;
    data['classID'] = classID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profile'] = profile;
    data['name'] = name;
    data['code'] = code;
    data['linkCode'] = linkCode;
    data['block'] = block;
    data['semester'] = semester;
    data['color'] = color;
    data['date_created'] = dateCreated;
    data['isArchived'] = isArchived;
    return data;
  }
}
