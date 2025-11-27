import 'package:flutter/material.dart';
import 'package:unitrack/utils/theme_colors.dart';
import 'app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UniTrack App',
      theme: appTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final ThemeData appTheme = ThemeData(
  primaryColor: ThemeColors.primary,
  scaffoldBackgroundColor: ThemeColors.background,
  cardColor: ThemeColors.cardBackground,
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: ThemeColors.text,
    displayColor: ThemeColors.text,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeColors.primary,
    foregroundColor: Colors.white, // for title and icons
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ThemeColors.primary,
    background: ThemeColors.background,
    onBackground: ThemeColors.text,
  ),
);
