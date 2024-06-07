class FeedbackModel {
  String? feedbackID;
  String? studentID;
  String? teacherClassID;
  String? senderID;
  String? message;
  String? dateCreated;
  String? teacherID;

  FeedbackModel(
      {this.feedbackID,
      this.studentID,
      this.teacherClassID,
      this.senderID,
      this.message,
      this.dateCreated,
      this.teacherID});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    feedbackID = json['feedbackID'].toString();
    studentID = json['studentID'].toString();
    teacherClassID = json['teacherClassID'].toString();
    senderID = json['senderID'].toString();
    message = json['message'].toString();
    dateCreated = json['dateCreated'].toString();
    teacherID = json['teacherID'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedbackID'] = feedbackID;
    data['studentID'] = studentID;
    data['teacherClassID'] = teacherClassID;
    data['senderID'] = senderID;
    data['message'] = message;
    data['dateCreated'] = dateCreated;
    data['teacherID'] = teacherID;
    return data;
  }
}
