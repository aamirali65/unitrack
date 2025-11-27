import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unitrack/screen/auth/sign_in_page.dart';
import 'package:unitrack/screen/auth/sign_up_page.dart';
import 'package:unitrack/screen/splash/view/splash.dart';
import 'package:unitrack/screen/student/student_dashboard.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
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
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const StudentDashboard(),
    ),
  ],
);
