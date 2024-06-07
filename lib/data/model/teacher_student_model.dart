class TeacherStudentModel {
  String? classroomID;
  String? studentID;
  String? teacherClassID;
  String? grade;
  String? classID;
  String? teacherID;
  String? firstName;
  String? lastName;
  String? profile;
  String? emailAddress;
  List<FeedbackItem> feedback;

  TeacherStudentModel({
    this.classroomID,
    this.studentID,
    this.teacherClassID,
    this.grade,
    this.classID,
    this.teacherID,
    this.firstName,
    this.lastName,
    this.profile,
    this.emailAddress,
    required this.feedback,
  });

  factory TeacherStudentModel.fromJson(Map<String, dynamic> json) {
    List<FeedbackItem> feedbackList = [];
    if (json['feedback'] != null) {
      feedbackList = List<FeedbackItem>.from(
          json['feedback'].map((item) => FeedbackItem.fromJson(item)));
    }
    return TeacherStudentModel(
      classroomID: json['classroomID'].toString(),
      studentID: json['studentID'].toString(),
      teacherClassID: json['teacherClassID'].toString(),
      grade: json['grade'].toString(),
      classID: json['classID'].toString(),
      teacherID: json['teacherID'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      profile: json['profile']?.toString(),
      emailAddress: json['emailAddress'].toString(),
      feedback: feedbackList,
    );
  }
}

class FeedbackItem {
  String? feedbackID;
  String? senderID;
  String? message;
  String? dateCreated;

  FeedbackItem({
    this.feedbackID,
    this.senderID,
    this.message,
    this.dateCreated,
  });

  factory FeedbackItem.fromJson(Map<String, dynamic> json) {
    return FeedbackItem(
      feedbackID: json['feedbackID'].toString(),
      senderID: json['senderID'].toString(),
      message: json['message'].toString(),
      dateCreated: json['dateCreated'].toString(),
    );
  }
}
