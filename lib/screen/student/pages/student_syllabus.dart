import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';
import '../../../widget/buildCustomTable.dart';

class StudentSyllabusPage extends StatefulWidget {
  const StudentSyllabusPage({super.key});

  @override
  State<StudentSyllabusPage> createState() => _StudentSyllabusPageState();
}

class _StudentSyllabusPageState extends State<StudentSyllabusPage> {
  final List<String> courses = [
    'DSA Theory',
    'Coal Theory',
    'Discrete',
    'DSA Lab',
    'Coal Lab',
    'M.P',
    'HCL Theory',
    'HCL Lab'
  ];

  String? selectedCourse;

  final int totalWeeks = 16;
  final int currentWeek = 7; // user at week 7

  // For each week we store syllabus text
  Map<int, String> syllabusMap = {};

  @override
  void initState() {
    super.initState();

    // sample syllabus for demo (can replace with DB data)
    for (int i = 1; i <= currentWeek; i++) {
      syllabusMap[i] = "Completed topics for week $i";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Syllabus",
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

              const SizedBox(height: 10),

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

                    // load syllabus dynamically or from DB
                    syllabusMap.clear();
                    for (int i = 1; i <= currentWeek; i++) {
                      syllabusMap[i] = "Completed topics for week $i";
                    }
                  });
                },
              ),

              const SizedBox(height: 24),

              selectedCourse == null
                  ? const Center(
                child: CustomText(
                  text: "Please select a course to view syllabus.",
                  fontSize: 16,
                  color: Colors.grey,
                ),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: totalWeeks,
                  itemBuilder: (context, index) {
                    final week = index + 1;
                    final isCompleted = week <= currentWeek;
                    final syllabus = syllabusMap[week] ?? "Pending";

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCompleted
                              ? Colors.green
                              : Colors.grey.withOpacity(0.5),
                          width: 1.3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Week $week",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ThemeColors.primary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                syllabus,
                                style: TextStyle(
                                  color: isCompleted
                                      ? Colors.black
                                      : Colors.grey.shade600,
                                ),
                              )
                            ],
                          ),

                          ElevatedButton(
                            onPressed: () {
                              // TODO: open PDF or download
                              print("Show PDF for Week $week");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Download PDF",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
