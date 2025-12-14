import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../utils/theme_colors.dart';

class TeacherStudentlist extends StatefulWidget {
  const TeacherStudentlist({super.key});

  @override
  State<TeacherStudentlist> createState() => _TeacherStudentlistState();
}

class _TeacherStudentlistState extends State<TeacherStudentlist> {
  Map<String, List<String>> coursesBySemester = {};
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> filteredStudents = [];

  String? selectedSemester;
  String? selectedCourse;

  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Load courses JSON
    final coursesJsonString = await rootBundle.loadString('assets/course.json');
    final Map<String, dynamic> coursesJson = json.decode(coursesJsonString);
    coursesBySemester = coursesJson.map((key, value) => MapEntry(key, List<String>.from(value)));

    // Load students JSON
    final studentsJsonString = await rootBundle.loadString('assets/student.json');
    final List<dynamic> studentsJson = json.decode(studentsJsonString);
    students = studentsJson.cast<Map<String, dynamic>>();

    setState(() {
      isLoading = false;
      filterStudents();
    });
  }

  void filterStudents() {
    List<Map<String, dynamic>> tempList = students;

    if (selectedSemester != null) {
      tempList = tempList.where((student) => student['semester'] == selectedSemester).toList();
    }

    if (selectedCourse != null) {
      tempList = tempList.where((student) => student['course'] == selectedCourse).toList();
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      tempList = tempList.where((student) {
        final id = (student['id'] ?? '').toString().toLowerCase();
        final name = (student['name'] ?? '').toString().toLowerCase();
        final course = (student['course'] ?? '').toString().toLowerCase();
        return id.contains(query) || name.contains(query) || course.contains(query);
      }).toList();
    }

    setState(() {
      filteredStudents = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> courses = selectedSemester != null ? coursesBySemester[selectedSemester!] ?? [] : [];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: ThemeColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Semester",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            _customDropdown<String>(
              value: selectedSemester,
              hintText: 'Choose Semester',
              items: coursesBySemester.keys.toList(),
              onChanged: (val) {
                setState(() {
                  selectedSemester = val;
                  selectedCourse = null;
                });
                filterStudents();
              },
            ),
            const SizedBox(height: 24),
            const Text(
              "Select Course",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            _customDropdown<String>(
              value: selectedCourse,
              hintText: 'Choose Course',
              items: courses,
              onChanged: (val) {
                setState(() {
                  selectedCourse = val;
                });
                filterStudents();
              },
            ),
            const SizedBox(height: 24),

            // Search Box
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by ID, Name or Course',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) {
                searchQuery = val;
                filterStudents();
              },
            ),
            const SizedBox(height: 24),

            filteredStudents.isEmpty
                ? const Center(
              child: Text(
                'No students found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      ThemeColors.primary.withOpacity(0.1),
                    ),
                    columnSpacing: 40,
                    dataRowHeight: 56,
                    columns: const [
                      DataColumn(
                        label: Text('Sr No', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('S.ID', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Course', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      filteredStudents.length,
                          (index) {
                        final s = filteredStudents[index];
                        return DataRow(
                          cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(s['id'] ?? '')),
                            DataCell(Text(s['name'] ?? '')),
                            DataCell(Text(s['course'] ?? '')),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customDropdown<T>({
    required T? value,
    required String hintText,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButton<T>(
        value: value,
        hint: Text(
          hintText,
          style: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w600),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: const SizedBox(),
        iconEnabledColor: ThemeColors.primary,
        style: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w600),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              style: TextStyle(color: ThemeColors.primary),
            ),
          ),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
