import 'package:flutter/material.dart';
import 'package:unitrack/DSA/syllabus_search.dart';
import 'package:unitrack/Models/Syllabus_model.dart';
import 'package:unitrack/Models/syllabus_manager.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';


class StudentSyllabusPage extends StatefulWidget {
  const StudentSyllabusPage({super.key});

  @override
  State<StudentSyllabusPage> createState() => _StudentSyllabusPageState();
}

class _StudentSyllabusPageState extends State<StudentSyllabusPage> {
  String? selectedCourse;
  int? selectedWeek;

  final TextEditingController weekController = TextEditingController();

  List<String> courses = [];
  SyllabusSearch? activeCourse;

  List<SyllabusSearch> allCourses = [];


  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {

    allCourses = await SyllabusManager.loadCourse();

    courses = allCourses.map((c) => c.courseName).toList();

    print("Courses loaded: $courses");

    if (mounted) {
      setState(() {});
    }
  }

  // function to find and set the active course
  void updateActiveCourse(String? course) {
    setState(() {
      selectedCourse = course;

      if  (course == null) {
        activeCourse = null;
      } else {
        // Find the full course object that matches the selected name
        activeCourse = allCourses.firstWhere((c) => c.courseName == course);
      }
      // Reset the week when the course changes
      selectedWeek = null;
      weekController.clear();
    });
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
                value: selectedCourse,
                hint: Text("Choose course",
                    style: TextStyle(color: ThemeColors.primary)),
                items: courses.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course,
                        style: TextStyle(color: ThemeColors.primary)),
                  );
                }).toList(),
                onChanged: (val) {
                  updateActiveCourse(val);
                },
              ),

              const SizedBox(height: 24),
              TextFormField(
                controller: weekController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Week Number",
                  hintText: "Enter a week (e.g., 5)",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                onChanged: (val) {
                  setState(() {
                    selectedWeek = int.tryParse(val);
                  });
                },
              ),
              const SizedBox(height: 24),

              Expanded(
                child: Builder(
                  builder: (context) {
                    if (activeCourse == null) {
                      return const Center(
                        child: CustomText(
                          text: "Please select a course.",
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      );
                    }
                    if (selectedWeek == null) {
                      return const Center(
                        child: CustomText(
                          text: "Enter a week number to see the syllabus.",
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      );
                    }

                    final WeekNode? result = activeCourse!.searchWeek(selectedWeek!);

                    if (result == null) {
                      return const Center(child: Text("No syllabus found for this week."));
                    }

                    return Card(

                      child: ListTile(

                        title: Text("Week ${result.weak}", style:  TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(result.syllabus),

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
