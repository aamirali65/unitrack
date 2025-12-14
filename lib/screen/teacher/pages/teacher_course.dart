import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme_colors.dart';

class TeacherMyCoursesPage extends StatelessWidget {
  const TeacherMyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        "title": "Discrete Mathematical Structures",
        "code": "DMS-221",
        "section": "BSCS-3A",
        "credit": "3 CH",
      },
      {
        "title": "Object Oriented Programming",
        "code": "OOP-231",
        "section": "BSCS-3B",
        "credit": "3 CH",
      },
      {
        "title": "Data Structures",
        "code": "DS-241",
        "section": "BSCS-4A",
        "credit": "3 CH",
      },
      {
        "title": "Database Systems",
        "code": "DB-251",
        "section": "BSCS-4B",
        "credit": "3 CH",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "My Courses",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: ThemeColors.primary,
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return InkWell(
            onTap: () {
              // context.push("/teacher/course-details", extra: course);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: ThemeColors.primary.withOpacity(0.15),
                    child: const Icon(
                      Icons.menu_book,
                      color: ThemeColors.primary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course["title"]!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          course["code"]!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Icon(Icons.group,
                                size: 18, color: ThemeColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              course["section"]!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(Icons.timer,
                                size: 18, color: ThemeColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              course["credit"]!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
