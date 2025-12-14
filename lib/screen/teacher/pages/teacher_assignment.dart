import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../utils/theme_colors.dart';

class TeacherAssignmentPage extends StatefulWidget {
  const TeacherAssignmentPage({super.key});

  @override
  State<TeacherAssignmentPage> createState() => _TeacherAssignmentPageState();
}

class _TeacherAssignmentPageState extends State<TeacherAssignmentPage> {
  String? selectedSemester;
  String? selectedCourse;
  String? selectedFileName;
  PlatformFile? selectedFile;

  final TextEditingController assignmentController = TextEditingController();
  DateTime? selectedDeadline;

  final List<String> semesters = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
  ];

  // Sample courses per semester
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
      withReadStream: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
        selectedFileName = selectedFile!.name;
      });
    }
  }

  Future<void> pickDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDeadline ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        selectedDeadline = picked;
      });
    }
  }

  @override
  void dispose() {
    assignmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> courses =
    selectedSemester != null ? coursesBySemester[selectedSemester!] ?? [] : [];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Assign Assignment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
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
                    selectedCourse = null;
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
              const SizedBox(height: 24),

              const Text(
                "Assignment Details",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: assignmentController,
                minLines: 4,
                maxLines: 7,
                decoration:
                _inputDecoration(hintText: "Write the assignment instructions here"),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 24),

              const Text(
                "Assignment Deadline",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: pickDeadline,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selectedDeadline != null
                          ? ThemeColors.primary
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDeadline != null
                            ? "${selectedDeadline!.day}/${selectedDeadline!.month}/${selectedDeadline!.year}"
                            : "Select deadline",
                        style: TextStyle(
                          fontSize: 15,
                          color: selectedDeadline != null
                              ? Colors.black87
                              : Colors.grey.shade600,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: ThemeColors.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "Upload Assignment PDF (Optional)",
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
                      assignmentController.text.trim().isNotEmpty &&
                      selectedDeadline != null)
                      ? () {
                    // TODO: Upload or assign logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Assignment assigned to $selectedCourse of $selectedSemester successfully!'),
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
                    "Assign Assignment",
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

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      hintText: hintText,
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
