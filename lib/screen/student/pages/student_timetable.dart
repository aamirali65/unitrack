import 'package:flutter/material.dart';
import 'package:unitrack/utils/theme_colors.dart';

class StudentTimetablePage extends StatefulWidget {
  const StudentTimetablePage({super.key});

  @override
  State<StudentTimetablePage> createState() => _StudentTimetablePageState();
}

class _StudentTimetablePageState extends State<StudentTimetablePage> {
  // Demo timetable data
  final Map<String, List<Map<String, String>>> timetable = {
    "Monday": [
      {"subject": "DSA Theory", "time": "09:15 AM to 11:15 AM"},
      {"subject": "Coal Theory", "time": "11:30 AM to 01:00 PM"},
    ],
    "Tuesday": [
      {"subject": "Discrete Math", "time": "09:15 AM to 12:30 PM"},
      {"subject": "HCL Lab", "time": "12:30 PM to 03:30 PM"},
    ],
    "Wednesday": [
      {"subject": "DSA Lab", "time": "10:00 AM to 01:00 PM"},
    ],
    "Thursday": [
      {"subject": "M.P", "time": "09:00 AM to 11:00 AM"},
      {"subject": "Coal Lab", "time": "11:15 AM to 02:15 PM"},
    ],
    "Friday": [
      {"subject": "HCL Theory", "time": "09:30 AM to 11:00 AM"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weekly Timetable",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: timetable.entries.map((entry) {
              final day = entry.key;
              final classes = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.primary,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Column(
                        children: classes.map((cls) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ThemeColors.primary.withOpacity(0.3),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cls["subject"]!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        cls["time"]!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.access_time, color: Colors.black87),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
