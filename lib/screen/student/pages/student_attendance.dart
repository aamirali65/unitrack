import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../providers/attendancedataprovider.dart';
import '../../../utils/theme_colors.dart';
import '../../../widget/buildCustomTable.dart';
import '../../../DSA/Customized_Hashmap.dart';
import '../../../Models/attendance_model.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  // Initialize with an empty list to prevent errors before data is loaded.
  List<String> courseList = [];

  Hash_Map<String, List<AttendanceNode>> attendanceMap = Hash_Map<String, List<AttendanceNode>>();

  String? selectedCourse;
  bool isLoading = true;

  int totalWeeks = 16;

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  Future<void> loadAttendance() async {
    // FIX: Wrap in a try-catch block to handle potential loading errors gracefully.
    try {
      attendanceMap = await AttendanceService.loadattendance();

      // Create a temporary list to populate.
      final loadedCourses = <String>[];
      for (var bucket in attendanceMap.Bukets) {
        var temp = bucket;
        while (temp != null) {
          loadedCourses.add(temp.key);
          temp = temp.next;
        }
      }

      setState(() {
        // Update the state with the fully loaded list.
        courseList = loadedCourses;
        isLoading = false;

        // FIX: Ensure selectedCourse is valid. If it's no longer in the list, reset it.
        if (selectedCourse != null && !courseList.contains(selectedCourse)) {
          selectedCourse = null;
        }
      });
    } catch (e) {
      // Handle any errors during data loading.
      print("Failed to load attendance data: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load attendance data.')),
        );
      }
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

              // Show a disabled dropdown while loading to prevent user interaction.
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                style: TextStyle(color: ThemeColors.primary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                hint: Text(
                  isLoading ? "Loading courses..." : "Choose course",
                  style: TextStyle(color: ThemeColors.primary),
                ),
                value: selectedCourse,
                // The dropdown items are now correctly built from the stateful `courseList`.
                items: courseList.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course, style: TextStyle(color: ThemeColors.primary)),
                  );
                }).toList(),
                // Disable the dropdown if loading or if there are no courses.
                onChanged: (isLoading || courseList.isEmpty) ? null : (val) {
                  setState(() {
                    selectedCourse = val;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Use the isLoading flag to show a progress indicator.
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (selectedCourse == null)
                const Center(
                  child: CustomText(
                    text: "Please select a course to view attendance.",
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Builder(
                      builder: (context) {
                        final List<AttendanceNode> statusList =
                            attendanceMap.get(selectedCourse!) ?? [];

                        return CustomTable(
                          col1: "Week",
                          col2: "Status",
                          key1: "week",
                          key2: "status",
                          rows: List.generate(totalWeeks, (index) {
                            final week = index + 1;

                            // --- THIS IS THE MAIN FIX FOR THE 'NULL' ERROR ---
                            // 1. Find the attendance node for the current week.
                            final attendanceNode = statusList.firstWhere(
                                  (node) => node.week == week,
                              // 2. If no node is found for that week, create a default one.
                              orElse: () => AttendanceNode(week: week, present: false),
                            );

                            // 3. Safely check the 'present' status. If it's null, default to false.
                            final bool isPresent = attendanceNode.present ?? false;

                            return {
                              "week": "Week $week",
                              "status": isPresent ? "Present" : "Absent",
                            };
                          }),
                        );
                      },
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
