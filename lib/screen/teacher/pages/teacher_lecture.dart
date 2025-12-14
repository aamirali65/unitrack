import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // import this
import '../../../utils/theme_colors.dart';

class TeacherLecturePage extends StatefulWidget {
  const TeacherLecturePage({super.key});

  @override
  State<TeacherLecturePage> createState() => _TeacherLecturePageState();
}

class _TeacherLecturePageState extends State<TeacherLecturePage> {
  String? selectedSemester;
  String? selectedCourse;
  String? selectedFileName;
  PlatformFile? selectedFile;

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

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withReadStream:
      true, // good for large files if you want to upload directly as stream
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
        selectedFileName = selectedFile!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> courses =
    selectedSemester != null ? coursesBySemester[selectedSemester!] ?? [] : [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        title: const Text(
          "Upload Lecture",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Semester",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedSemester,
                decoration: _inputDecoration(),
                hint: const Text("Choose Semester"),
                items: semesters
                    .map((sem) =>
                    DropdownMenuItem<String>(value: sem, child: Text(sem)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedSemester = val;
                    selectedCourse = null; // reset course on semester change
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Select Course",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedCourse,
                decoration: _inputDecoration(),
                hint: const Text("Choose Course"),
                items: courses
                    .map((course) =>
                    DropdownMenuItem<String>(value: course, child: Text(course)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCourse = val;
                  });
                },
              ),
              const SizedBox(height: 32),
              const Text(
                "Upload Lecture PDF",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: Text(selectedFileName ?? "Select PDF File",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primary,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: pickFile,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (selectedSemester != null &&
                      selectedCourse != null &&
                      selectedFile != null)
                      ? () {
                    // TODO: implement upload logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Lecture "${selectedFileName!}" uploaded successfully!'),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "Upload Lecture",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ThemeColors.primary, width: 2),
      ),
    );
  }
}
