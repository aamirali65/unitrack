
import 'package:flutter/material.dart';
import 'package:unitrack/utils/theme_colors.dart';
import 'package:unitrack/DSA/timetable.dart';

import '../../../DSA/Customized_Queue.dart';


class StudentTimetablePage extends StatefulWidget {
  const StudentTimetablePage({super.key});

  @override
  State<StudentTimetablePage> createState() => _StudentTimetablePageState();
}

class _StudentTimetablePageState extends State<StudentTimetablePage> {
  late Timetable timetable;
  late Timetable dayQueue;

  @override
  void initState() {
    super.initState();
    // Initialize the timetable object here
    timetable = Timetable();

    dayQueue = Timetable();
    loadData();
  }

  String _getToday() {
    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    return days[DateTime.now().weekday - 1];
  }

  Future<void> loadData() async {
    // Call the instance method to load data into the 'timetable' object
    await timetable.loadTimetable();

    dayQueue.loadDays(timetable.entries.map((e) => e.key).toList());

    // STEP 3: move today to front
    dayQueue.Todaytofront(_getToday());
    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        // Data is loaded, rebuild the UI to display it
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderedDays = dayQueue.toList();
    final today = _getToday();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weekly Timetable",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),



      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // The data in timetablemap get in this file from here
      children: orderedDays.map((day) {
        final classes = timetable.entries
            .firstWhere((e) => e.key == day)
            .value;

        final isToday = day == today;

              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isToday ? Colors.blue.shade50 : Colors.white,
                  border: isToday
                      ? Border.all(color: ThemeColors.primary, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isToday ? "$day (Today)" : day,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.primary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Column(
                        children: classes.map((cls) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ThemeColors.primary.withOpacity(0.3),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cls["subject"]!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        cls["time"]!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.access_time, color: Colors.black87),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
