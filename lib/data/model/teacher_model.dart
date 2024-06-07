class TeacherModel {
  String? teacherID;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  String? isPasswordChanged;
  String? profile;
  String? dateCreated;
  String? teacherClassID;

  TeacherModel(
      {this.teacherID,
      this.firstName,
      this.lastName,
      this.emailAddress,
      this.password,
      this.isPasswordChanged,
      this.profile,
      this.dateCreated,
      this.teacherClassID});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    teacherID = json['teacherID'].toString();
    firstName = json['firstName'].toString();
    lastName = json['lastName'].toString();
    emailAddress = json['emailAddress'].toString();
    password = json['password'].toString();
    isPasswordChanged = json['isPasswordChanged'].toString();
    profile = json['profile'].toString();
    dateCreated = json['date_created'].toString();
    teacherClassID = json['teacherClassID'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacherID'] = teacherID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emailAddress'] = emailAddress;
    data['password'] = password;
    data['isPasswordChanged'] = isPasswordChanged;
    data['profile'] = profile;
    data['date_created'] = dateCreated;
    data['teacherClassID'] = teacherClassID;
    return data;
  }
}
