import 'package:flutter/material.dart';
import 'package:unitrack/utils/theme_colors.dart';

class StudentExamsPage extends StatefulWidget {
  const StudentExamsPage({super.key});

  @override
  State<StudentExamsPage> createState() => _StudentExamsPageState();
}

class _StudentExamsPageState extends State<StudentExamsPage> {
  // Demo exam schedule
  final List<Map<String, String>> exams = [
    {
      "subject": "DSA Theory",
      "date": "12 Jan 2025",
      "time": "09:00 AM to 11:00 AM",
      "room": "Lab 02"
    },
    {
      "subject": "Discrete Math",
      "date": "14 Jan 2025",
      "time": "11:30 AM to 01:30 PM",
      "room": "Room 201"
    },
    {
      "subject": "Computer Architecture",
      "date": "17 Jan 2025",
      "time": "09:30 AM to 12:00 PM",
      "room": "Auditorium"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Exams",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
        elevation: 2,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------
          // INSTRUCTION SECTION BELOW APPBAR
          // -------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Important Exam Instructions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                _bullet("Make sure your admit card is printed and signed by the exam department."),
                _bullet("Reach the exam hall at least 30 minutes before the start time."),
                _bullet("Students arriving late will not be allowed to enter."),
                _bullet("Cheating or misconduct will result in disciplinary action."),
                _bullet("Bring your own stationery and required materials."),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // -------------------------------
          // MAIN CONTENT
          // -------------------------------
          Expanded(
            child: exams.isEmpty
                ? Center(
              child: Text(
                "No upcoming exams",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                ),
              ),
            )
                : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: exams.map((exam) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subject
                          Text(
                            exam["subject"]!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.primary,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Date
                          _row(Icons.calendar_month, exam["date"]!),

                          const SizedBox(height: 8),

                          // Time
                          _row(Icons.access_time, exam["time"]!),

                          const SizedBox(height: 8),

                          // Room
                          _row(Icons.room, exam["room"]!),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  // -------------------------------
  // SHARED WIDGETS
  // -------------------------------

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 15)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
