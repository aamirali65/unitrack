import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';

class CourseRecapSheetPage extends StatefulWidget {
  const CourseRecapSheetPage({super.key});

  @override
  State<CourseRecapSheetPage> createState() => _CourseRecapSheetPageState();
}

class _CourseRecapSheetPageState extends State<CourseRecapSheetPage> {
  final Map<String, List<Map<String, dynamic>>> coursesData = {
    "Discrete Mathematical Structures": [
      {'name': 'Quiz 1', 'max': 5, 'obtained': 4},
      {'name': 'Quiz 2', 'max': 5, 'obtained': 5},
      {'name': 'Assignment 1', 'max': 5, 'obtained': 3},
      {'name': 'Final Paper', 'max': 40, 'obtained': 35},
      {'name': 'Mid Term Paper', 'max': 30, 'obtained': 25},
    ],
    "Data Structures": [
      {'name': 'Quiz 1', 'max': 10, 'obtained': 8},
      {'name': 'Quiz 2', 'max': 10, 'obtained': 7},
      {'name': 'Assignment 1', 'max': 10, 'obtained': 9},
      {'name': 'Final Paper', 'max': 50, 'obtained': 40},
    ],
    "Operating Systems": [
      {'name': 'Quiz 1', 'max': 5, 'obtained': 3},
      {'name': 'Assignment 1', 'max': 10, 'obtained': 8},
      {'name': 'Final Paper', 'max': 40, 'obtained': 32},
      {'name': 'Mid Term Paper', 'max': 30, 'obtained': 26},
    ],
  };

  String? selectedCourse;  // Start null, no initial selection

  double totalObtained = 0;
  double totalMax = 0;
  double percentage = 0;

  void calculateResult() {
    final marksList = coursesData[selectedCourse] ?? [];

    totalObtained = 0;
    totalMax = 0;
    for (var item in marksList) {
      totalObtained += (item['obtained'] ?? 0);
      totalMax += (item['max'] ?? 0);
    }
    percentage = totalMax == 0 ? 0 : (totalObtained / totalMax) * 100;
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCourse != null) {
      calculateResult();
    }

    final marksList = selectedCourse != null ? coursesData[selectedCourse] ?? [] : [];

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Course Result",
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                items: coursesData.keys
                    .map((course) => DropdownMenuItem(
                  value: course,
                  child: Text(course, style: TextStyle(color: ThemeColors.primary)),
                ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCourse = val;
                  });
                },
              ),
              const SizedBox(height: 24),

              if (selectedCourse == null)
                Center(
                  child: const Expanded(
                    child: CustomText(
                      text: "Please select a course to view result.",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Table(
                            border: TableBorder.all(color: Colors.grey.shade300),
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(2),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                              // Header row
                              TableRow(
                                decoration: BoxDecoration(color: Colors.grey.shade100),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      "Marks Head",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: ThemeColors.primary),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      "Max Marks",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: ThemeColors.primary),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      "Marks Obtained",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: ThemeColors.primary),
                                    ),
                                  ),
                                ],
                              ),

                              // Marks rows
                              ...marksList.map(
                                    (item) => TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        item['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: ThemeColors.primary),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        item['max'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: ThemeColors.primary),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        (item['obtained'] == null)
                                            ? "Not Entered"
                                            : item['obtained'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontStyle: (item['obtained'] == null)
                                              ? FontStyle.italic
                                              : FontStyle.normal,
                                          color: (item['obtained'] == null)
                                              ? Colors.grey
                                              : ThemeColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Total row
                              TableRow(
                                decoration: BoxDecoration(color: Colors.grey.shade100),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      "Total Marks",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: ThemeColors.primary),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      totalMax.toInt().toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: ThemeColors.primary),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      "${totalObtained.toInt()}/$totalMax (${percentage.toStringAsFixed(1)}%)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: ThemeColors.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
