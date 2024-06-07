import 'package:get/get.dart';
import 'package:smart_grade_viewer/view/screen/admin/admin_dashboard.dart';
import 'package:smart_grade_viewer/view/screen/admin/teacher_details.dart';
import 'package:smart_grade_viewer/view/screen/auth/login.dart';
import 'package:smart_grade_viewer/view/screen/auth/register.dart';
import 'package:smart_grade_viewer/view/screen/student/drawer/overall_grades.dart';
import 'package:smart_grade_viewer/view/screen/student/drawer/student_archive.dart';
import 'package:smart_grade_viewer/view/screen/student/drawer/student_change_password.dart';
import 'package:smart_grade_viewer/view/screen/student/drawer/student_edit_profile.dart';
import 'package:smart_grade_viewer/view/screen/student/drawer/student_profile.dart';
import 'package:smart_grade_viewer/view/screen/student/home/student_class_page.dart';
import 'package:smart_grade_viewer/view/screen/student/home/student_dashboard.dart';
import 'package:smart_grade_viewer/view/screen/student/home/student_evaluation_page.dart';
import 'package:smart_grade_viewer/view/screen/student/home/student_view_student_list.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_archive.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_change_password.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_evaluation.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_evaluation_dashboard.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_evaluation_details.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teacher_profile.dart';
import 'package:smart_grade_viewer/view/screen/teacher/drawer/teahcer_edit_profile.dart';
import 'package:smart_grade_viewer/view/screen/teacher/home/teacher_class_page.dart';
import 'package:smart_grade_viewer/view/screen/teacher/home/teacher_dashboard.dart';
import 'package:smart_grade_viewer/view/screen/teacher/home/teacher_ranking_page.dart';
import 'package:smart_grade_viewer/view/screen/teacher/home/teacher_request_page.dart';

import 'core/constant/routes.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const LoginPage()),

  // ********************** Authentication
  GetPage(
      name: AppRoute.loginPage,
      page: () => const LoginPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.registerPage,
      page: () => const RegisterPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  // ********************** Student
  GetPage(
    name: AppRoute.studentDashboard,
    page: () => const StudentDashboard(),
  ),
  GetPage(
      name: AppRoute.studentClassPage,
      page: () => const StudentClassPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.studentViewStudentList,
      page: () => const StudentViewStudentList(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.studentArchive,
      page: () => const StudentArchive(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  GetPage(
      name: AppRoute.studentProfile,
      page: () => const StudentProfile(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.studentEditProfile,
      page: () => const StudentEditProfile(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.studentChangePassword,
      page: () => const StudentChangePassword(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.studentEvaluationPage,
      page: () => StudentEvaluationPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.overallGrades,
      page: () => const OverallGrades(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  // ********************** Teacher
  GetPage(
    name: AppRoute.teacherDashboard,
    page: () => const TeacherDashboard(),
  ),
  GetPage(
      name: AppRoute.teacherClassPage,
      page: () => const TeacherClassPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherRequestPage,
      page: () => const TeacherRequestPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherRankingPage,
      page: () => const TeacherRankingPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherArchive,
      page: () => const TeacherArchive(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherProfile,
      page: () => const TeacherProfile(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherEvaluation,
      page: () => const TeacherEvaluation(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherEditProfile,
      page: () => const TeacherEditProfile(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherChangePassword,
      page: () => const TeacherChangePassword(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherEvaluationDashboard,
      page: () => const TeacherEvaluationDashboard(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
  GetPage(
      name: AppRoute.teacherEvaluationDetails,
      page: () => const TeacherEvaluationDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),

  // ********************** Admin
  GetPage(
    name: AppRoute.adminDashboard,
    page: () => const AdminDashboard(),
  ),
  GetPage(
      name: AppRoute.teacherDetails,
      page: () => const TeacherDetails(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200)),
];
