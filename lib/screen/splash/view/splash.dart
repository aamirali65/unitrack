import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get device width for responsive font size
    final width = MediaQuery.of(context).size.width;

    // Simple responsive font size calculation
    double responsiveFontSize(double baseSize) {
      if (width <= 320) return baseSize * 0.8;       // small phones
      if (width <= 480) return baseSize * 0.9;       // medium phones
      if (width <= 720) return baseSize;             // normal phones
      return baseSize * 1.1;                          // tablets, large screens
    }

    return Scaffold(
      backgroundColor: const Color(0xFF002C53), // main color bg
      body: Center(
        child: Text(
          'UniTrack\nUniversity Portal',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsiveFontSize(36), // base size 36
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
