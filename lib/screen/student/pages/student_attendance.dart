import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';
import '../../../widget/buildCustomTable.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  final List<String> courses = ['DSA Thoery', 'Coal Thoery', 'Discrete','DSA Lab', 'Coal Lab', 'M.P','HCL Thoery','HCL Lab'];

  String? selectedCourse;
  final int totalWeeks = 16;
  final int currentWeek = 8;

  Map<int, String> attendanceStatus = {};

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= currentWeek; i++) {
      attendanceStatus[i] = (i % 3 == 0) ? 'Absent' : 'Present';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Show Attendance",
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Select Course:",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                style: TextStyle(color: ThemeColors.primary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                hint: Text("Choose course", style: TextStyle(color: ThemeColors.primary)),
                value: selectedCourse,
                items: courses.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course, style: TextStyle(color: ThemeColors.primary)),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCourse = val;
                    attendanceStatus.clear();
                    for (int i = 1; i <= currentWeek; i++) {
                      attendanceStatus[i] = (i % 2 == 0) ? 'Present' : 'Absent';
                    }
                  });
                },
              ),

              const SizedBox(height: 24),

              selectedCourse == null
                  ? const Center(
                child: CustomText(
                  text: "Please select a course to view attendance.",
                  fontSize: 16,
                  color: Colors.grey,
                ),
              )
                  : Expanded(
                child: SingleChildScrollView(
                  child: CustomTable(
                    col1: "Week",
                    col2: "Status",
                    key1: "week",
                    key2: "status",
                    rows: List.generate(totalWeeks, (index) {
                      final week = index + 1;
                      return {
                        "week": "Week $week",
                        "status": attendanceStatus[week] ?? "Not Entered",
                      };
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
