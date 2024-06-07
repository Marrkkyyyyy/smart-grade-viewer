class AppLink {
  // static String server = "http://192.168.1.8/smart_grade_viewer";
  static String server = "https://sgv.yfcfarmfinds.com";
  static String userProfile = "$server/auth/user_profile/";

  // ================================= Auth ====================================
  static String register = "$server/auth/register.php";
  static String login = "$server/auth/login.php";
  static String loginNewPassword = "$server/auth/login_new_password.php";
  static String changePassword = "$server/auth/change_password.php";

  // ================================= Admin ====================================

  static String fetchTeacer = "$server/admin/fetch_teacher.php";

  // ================================= Teacher ====================================
  static String createNewClass = "$server/teacher/create_new_class.php";
  static String fetchTeacherClass = "$server/teacher/fetch_teacher_class.php";
  static String fetchTeacherStudent =
      "$server/teacher/fetch_teacher_student.php";
  static String fetchRequests = "$server/teacher/fetch_request.php";
  static String rejectRequest = "$server/teacher/reject_request.php";
  static String acceptRequest = "$server/teacher/accept_request.php";
  static String submitGrade = "$server/teacher/submit_grade.php";
  static String unenrollStudent = "$server/teacher/unenroll_student.php";
  static String teacherEditProfile = "$server/teacher/teacher_edit_profile.php";
  static String teacherArchive =
      "$server/teacher/teacher_manipulate_archive.php";
  static String fetchTeacherArchive =
      "$server/teacher/fetch_teacher_archive.php";
  static String fetchEvaluation = "$server/teacher/fetch_evaluation.php";

  // ================================= Student ====================================
  static String editProfile = "$server/student/student_edit_profile.php";
  static String sendFeedback = "$server/student/send_feedback.php";
  static String joinClass = "$server/student/join_class.php";
  static String fetchStudentClass = "$server/student/fetch_student_class.php";
  static String fetchStudent = "$server/student/fetch_student.php";
  static String fetchFeedback = "$server/student/fetch_student_feedback.php";
  static String studentArchive =
      "$server/student/student_manipulate_archive.php";
  static String fetchStudentArchive =
      "$server/student/fetch_student_archive.php";
  static String studentEvaluate = "$server/student/submit_evaluation.php";
  static String fetchOverallGrades = "$server/student/fetch_overall_grades.php";
}
