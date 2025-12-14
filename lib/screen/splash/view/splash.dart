import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Add this import
import 'package:unitrack/widget/MyText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndRedirect();
  }

  Future<void> _checkAuthAndRedirect() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      // No user logged in, redirect to login after a delay
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) context.go('/login');
      return;
    }

    try {
      // Fetch the role from your profiles table (adjust table/column names as per your DB)
      final profile = await supabase
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();

      String role = '';

      if (profile != null && profile is Map<String, dynamic>) {
        role = profile['role'] ?? '';
      }

      await Future.delayed(const Duration(seconds: 3)); // Show splash for 3 seconds

      if (!mounted) return;

      // Redirect based on role
      switch (role.toLowerCase()) {
        case 'student':
          context.go('/student/dashboard');
          break;
        case 'teacher':
          context.go('/teacher/dashboard');
          break;
        default:
        // If role not found or unknown, send to login or a generic page
          context.go('/login');
      }
    } catch (e) {
      // On error, fallback to login screen after delay
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double responsiveFontSize(double baseSize) {
      if (width <= 320) return baseSize * 0.8;
      if (width <= 480) return baseSize * 0.9;
      if (width <= 720) return baseSize;
      return baseSize * 1.1;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF002C53),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.contain,
              width: 200,
            ),
            const SizedBox(height: 10),
            CustomText(
              text: 'UniTrack\nUniversity Portal',
              textAlign: TextAlign.center,
              color: Colors.white,
              fontSize: responsiveFontSize(30),
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
