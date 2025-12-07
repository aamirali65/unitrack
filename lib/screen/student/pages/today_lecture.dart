import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';
import '../../../widget/buildCustomTable.dart';

class TodayLecture extends StatelessWidget {
  const TodayLecture({super.key});

  final List<Map<String, String>> lectures = const [
    {'time': '9:15 AM - 12:30 PM', 'subject': 'Physics Class'},
    {'time': '12:30 PM - 1:00 PM', 'subject': 'Break'},
    {'time': '1:30 PM - 3:30 PM', 'subject': 'Mathematics Class'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Today Lectures", color: Colors.white),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomTable(
            col1: "Time",
            col2: "Lecture",
            key1: "time",
            key2: "subject",
            rows: lectures,
          ),
        ),
      ),
    );
  }
}
