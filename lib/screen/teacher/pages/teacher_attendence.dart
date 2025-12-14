import 'package:flutter/material.dart';
import '../../../utils/theme_colors.dart';

class TeacherAttendancePage extends StatefulWidget {
  const TeacherAttendancePage({super.key});

  @override
  State<TeacherAttendancePage> createState() => _TeacherAttendancePageState();
}

class _TeacherAttendancePageState extends State<TeacherAttendancePage> {
  String? selectedSemester;
  String? selectedCourse;

  final List<String> semesters = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
  ];

  final Map<String, List<String>> coursesBySemester = {
    'Semester 1': ['Math Basics', 'Intro to CS', 'English'],
    'Semester 2': ['Data Structures', 'Physics', 'Chemistry'],
    'Semester 3': ['Discrete Math', 'OOP', 'Database Systems'],
    'Semester 4': ['Algorithms', 'Operating Systems', 'Networks'],
    'Semester 5': ['Software Engineering', 'AI', 'Web Development'],
    'Semester 6': ['Mobile Dev', 'Cloud Computing', 'Machine Learning'],
  };

  final Map<String, Map<String, List<Map<String, String>>>> studentsBySemesterCourse = {
    'Semester 1': {
      'Math Basics': [
        {'id': '2412112', 'name': 'Ali Khan'},
        {'id': '2412123', 'name': 'Sara Ahmed'},
        {'id': '2412100', 'name': 'Zain Malik'},
      ],
      'Intro to CS': [
        {'id': '2412177', 'name': 'Ahmed Ali'},
        {'id': '2412123', 'name': 'Fatima Noor'},
      ],
      'English': [
        {'id': '2412196', 'name': 'Hassan Raza'},
        {'id': '2412128', 'name': 'Ayesha Khan'},
      ],
    },
    'Semester 2': {
      'Data Structures': [
        {'id': '2412111', 'name': 'Bilal Aslam'},
        {'id': '2412188', 'name': 'Nida Saleem'},
      ],
      'Physics': [
        {'id': '2412172', 'name': 'Asim Iqbal'},
        {'id': '2412174', 'name': 'Hina Tariq'},
      ],
      'Chemistry': [
        {'id': 'S205', 'name': 'Fahad Malik'},
        {'id': 'S206', 'name': 'Sara Zaman'},
      ],
    },
  };

  final List<String> attendanceOptions = ['Present', 'Absent', 'Excused', 'Late'];

  final Map<String, String> attendanceRecords = {};

  @override
  Widget build(BuildContext context) {
    List<String> courses =
    selectedSemester != null ? coursesBySemester[selectedSemester!] ?? [] : [];

    List<Map<String, String>> students = [];
    if (selectedSemester != null && selectedCourse != null) {
      students = studentsBySemesterCourse[selectedSemester!]?[selectedCourse!] ?? [];
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Take Attendance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: ThemeColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
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
              items: semesters,
              onChanged: (val) {
                setState(() {
                  selectedSemester = val;
                  selectedCourse = null;
                  attendanceRecords.clear();
                });
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
                  attendanceRecords.clear();
                });
              },
            ),
            const SizedBox(height: 24),
            if (students.isEmpty)
              const Center(
                child: Text(
                  'No students found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            else
              Expanded(
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
                      headingRowColor:
                      MaterialStateProperty.all(ThemeColors.primary.withOpacity(0.1)),
                      columnSpacing: 25,
                      dataRowHeight: 56,
                      columns: const [
                        DataColumn(
                            label: Text('Sr No',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('S.ID',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Name',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Attendance',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: List<DataRow>.generate(
                        students.length,
                            (index) {
                          final student = students[index];
                          final studentId = student['id']!;
                          final attendance = attendanceRecords[studentId] ?? attendanceOptions[0];

                          return DataRow(
                            cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(studentId)),
                              DataCell(Text(student['name'] ?? '')),
                              DataCell(
                                DropdownButton<String>(
                                  value: attendance,
                                  dropdownColor: Colors.white,
                                  style: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w600),
                                  underline: const SizedBox(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() {
                                        attendanceRecords[studentId] = val;
                                      });
                                    }
                                  },
                                  items: attendanceOptions
                                      .map((option) => DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  ))
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: students.isNotEmpty && attendanceRecords.length == students.length
                  ? () {
                // TODO: Save attendance to backend
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Attendance saved for $selectedCourse of $selectedSemester'),
                  ),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Center(
                child: Text(
                  'Submit Attendance',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
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
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString(),
            style: TextStyle(color: ThemeColors.primary),
          ),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
