import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:unitrack/screen/auth/sign_in_page.dart';
import 'package:unitrack/screen/auth/sign_up_page.dart';
import 'package:unitrack/screen/splash/view/splash.dart';

// Student Screens
import 'package:unitrack/screen/student/student_dashboard.dart';
import 'package:unitrack/screen/student/pages/today_lecture.dart';
import 'package:unitrack/screen/student/pages/student_attendance.dart';
import 'package:unitrack/screen/student/pages/student_results.dart';
import 'package:unitrack/screen/student/pages/student_syllabus.dart';
import 'package:unitrack/screen/student/pages/student_timetable.dart';
import 'package:unitrack/screen/student/pages/student_exam.dart';
import 'package:unitrack/screen/student/pages/student_profile.dart';
import 'package:unitrack/screen/student/pages/student_settings.dart';
import 'package:unitrack/screen/student/pages/student_fees.dart';

// Teacher Screens
import 'package:unitrack/screen/teacher/teacher_dashboard.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Public routes
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const SignUpPage(),
    ),

    // ------------------ STUDENT ROUTES ------------------
    GoRoute(
      path: '/student/dashboard',
      builder: (context, state) => const StudentDashboard(),
    ),
    GoRoute(
      path: '/student/today-lecture',
      builder: (context, state) => const TodayLecture(),
    ),
    GoRoute(
      path: '/student/attendance',
      builder: (context, state) => const StudentAttendancePage(),
    ),
    GoRoute(
      path: '/student/syllabus',
      builder: (context, state) => const StudentSyllabusPage(),
    ),
    GoRoute(
      path: '/student/timetable',
      builder: (context, state) => const StudentTimetablePage(),
    ),
    GoRoute(
      path: '/student/exams',
      builder: (context, state) => const StudentExamsPage(),
    ),
    GoRoute(
      path: '/student/results',
      builder: (context, state) => const CourseRecapSheetPage(),
    ),
    GoRoute(
      path: '/student/fees',
      builder: (context, state) => const StudentFeesPage(),
    ),
    GoRoute(
      path: '/student/profile',
      builder: (context, state) => const StudentProfilePage(),
    ),
    GoRoute(
      path: '/student/settings',
      builder: (context, state) => const StudentSettingsPage(),
    ),

    // ------------------ TEACHER ROUTES ------------------
    GoRoute(
      path: '/teacher/dashboard',
      builder: (context, state) => const TeacherDashboard(),
    ),
    // GoRoute(
    //   path: '/teacher/today-lecture',
    //   builder: (context, state) => const TeacherTodayLecturePage(),
    // ),
    // GoRoute(
    //   path: '/teacher/attendance',
    //   builder: (context, state) => const TeacherAttendancePage(),
    // ),
    // GoRoute(
    //   path: '/teacher/syllabus',
    //   builder: (context, state) => const TeacherSyllabusPage(),
    // ),
    // GoRoute(
    //   path: '/teacher/timetable',
    //   builder: (context, state) => const TeacherTimetablePage(),
    // ),
    // GoRoute(
    //   path: '/teacher/exams',
    //   builder: (context, state) => const TeacherExamsPage(),
    // ),
    // GoRoute(
    //   path: '/teacher/results',
    //   builder: (context, state) => const TeacherResultsPage(),
    // ),
    // GoRoute(
    //   path: '/teacher/fees',
    //   builder: (context, state) => const TeacherFeesPage(),
    // ),
    // GoRoute(
    //   path: '/teacher/profile',
    //   builder: (context, state) => const TeacherProfilePage(),
    // ),
    // GoRoute(
    //   path: '/teacher/settings',
    //   builder: (context, state) => const TeacherSettingsPage(),
    // ),
  ],
);
