class EvaluationModel {
  String? evaluationID;
  String? studentID;
  String? teacherClassID;
  String? evaluation;
  String? comment;
  String? dateCreated;

  EvaluationModel(
      {this.evaluationID,
      this.studentID,
      this.teacherClassID,
      this.evaluation,
      this.comment,
      this.dateCreated});

  EvaluationModel.fromJson(Map<String, dynamic> json) {
    evaluationID = json['evaluationID'].toString();
    studentID = json['studentID'].toString();
    teacherClassID = json['teacherClassID'].toString();
    evaluation = json['evaluation'].toString();
    comment = json['comment'].toString();
    dateCreated = json['dateCreated'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['evaluationID'] = evaluationID;
    data['studentID'] = studentID;
    data['teacherClassID'] = teacherClassID;
    data['evaluation'] = evaluation;
    data['comment'] = comment;
    data['dateCreated'] = dateCreated;
    return data;
  }
}
