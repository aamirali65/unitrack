import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unitrack/utils/theme_colors.dart';
import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dgmcxmvvqpurhyklejzj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRnbWN4bXZ2cXB1cmh5a2xlanpqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQyNjMxMzMsImV4cCI6MjA3OTgzOTEzM30.pZOeiquSpvG_oQqvDtaYXxSTndKedUMH1XSqjNS4ObU',
  );

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
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ThemeColors.primary,
    background: ThemeColors.background,
    onBackground: ThemeColors.text,
  ),
);
