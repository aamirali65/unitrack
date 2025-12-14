import 'package:flutter/material.dart';
import '../../../utils/theme_colors.dart';

class TeacherUploadResultPage extends StatefulWidget {
  const TeacherUploadResultPage({super.key});

  @override
  State<TeacherUploadResultPage> createState() => _TeacherUploadResultPageState();
}

class _TeacherUploadResultPageState extends State<TeacherUploadResultPage> {
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

  final Map<String, Map<String, List<Map<String, dynamic>>>> students = {
    'Semester 1': {
      'Math Basics': [
        {'id': '2412112', 'name': 'Ali Khan'},
        {'id': '2412123', 'name': 'Sara Ahmed'},
        {'id': '2412100', 'name': 'Zain Malik'},
      ]
    },
    'Semester 2': {
      'Data Structures': [
        {'id': '2412188', 'name': 'Nida Saleem'},
        {'id': '2412172', 'name': 'Asim Iqbal'},
      ]
    }
  };

  Map<String, Map<String, dynamic>> marks = {};

  @override
  Widget build(BuildContext context) {
    List<String> courseList =
    selectedSemester != null ? coursesBySemester[selectedSemester!] ?? [] : [];

    List<Map<String, dynamic>> studentList = [];
    if (selectedSemester != null && selectedCourse != null) {
      studentList = students[selectedSemester!]?[selectedCourse!] ?? [];
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        title: const Text("Upload Result", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Semester", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _dropdown(
              value: selectedSemester,
              items: semesters,
              hint: "Choose Semester",
              onChanged: (val) {
                setState(() {
                  selectedSemester = val;
                  selectedCourse = null;
                });
              },
            ),

            const SizedBox(height: 16),
            const Text("Select Course", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _dropdown(
              value: selectedCourse,
              items: courseList,
              hint: "Choose Course",
              onChanged: (val) {
                setState(() {
                  selectedCourse = val;
                });
              },
            ),

            const SizedBox(height: 22),

            studentList.isEmpty
                ? const Expanded(
              child: Center(child: Text("No students found", style: TextStyle(color: Colors.grey))),
            )
                : Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      ThemeColors.primary.withOpacity(0.1),
                    ),
                    columnSpacing: 40,
                    columns: const [
                      DataColumn(label: Text("S.ID")),
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Quiz")),
                      DataColumn(label: Text("Assign")),
                      DataColumn(label: Text("Mid")),
                      DataColumn(label: Text("Final")),
                      DataColumn(label: Text("Action")),
                    ],
                    rows: studentList.map((student) {
                      final id = student['id'];

                      final studentMarks = marks[id] ?? {
                        "quiz": "-",
                        "assignment": "-",
                        "mid": "-",
                        "final": "-",
                      };

                      return DataRow(
                        cells: [
                          DataCell(Text(student['id'])),
                          DataCell(Text(student['name'])),
                          DataCell(Text("${studentMarks['quiz']}")),
                          DataCell(Text("${studentMarks['assignment']}")),
                          DataCell(Text("${studentMarks['mid']}")),
                          DataCell(Text("${studentMarks['final']}")),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                _openMarkModal(student);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              ),
                              child: Text(
                                marks[id] == null ? "Add Marks" : "Edit",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK ENTRY MODAL
  void _openMarkModal(Map<String, dynamic> student) {
    final id = student["id"];

    final quiz = TextEditingController(text: marks[id]?["quiz"]?.toString() ?? "");
    final assignment = TextEditingController(text: marks[id]?["assignment"]?.toString() ?? "");
    final mid = TextEditingController(text: marks[id]?["mid"]?.toString() ?? "");
    final finalMarks = TextEditingController(text: marks[id]?["final"]?.toString() ?? "");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Marks for ${student['name']}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                _markInput("Quiz (5)", quiz),
                const SizedBox(height: 14),

                _markInput("Assignment (5)", assignment),
                const SizedBox(height: 14),

                _markInput("Mid (30)", mid),
                const SizedBox(height: 14),

                _markInput("Final (60)", finalMarks),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          marks[id] = {
                            "quiz": quiz.text,
                            "assignment": assignment.text,
                            "mid": mid.text,
                            "final": finalMarks.text,
                          };
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primary,
                      ),
                      child: const Text("Save",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


  // --- UI HELPERS ---
  Widget _dropdown({
    required dynamic value,
    required List items,
    required String hint,
    required Function(dynamic) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton(
        value: value,
        hint: Text(hint, style: TextStyle(color: ThemeColors.primary)),
        isExpanded: true,
        dropdownColor: Colors.white,
        underline: const SizedBox(),
        iconEnabledColor: ThemeColors.primary,
        items: items
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: TextStyle(color: ThemeColors.primary)),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _markInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
