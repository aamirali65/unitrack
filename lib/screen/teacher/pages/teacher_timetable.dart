import 'package:flutter/material.dart';
import '../../../utils/theme_colors.dart';

class TeacherTimeTablePage extends StatefulWidget {
  const TeacherTimeTablePage({super.key});

  @override
  State<TeacherTimeTablePage> createState() => _TeacherTimeTablePageState();
}

class _TeacherTimeTablePageState extends State<TeacherTimeTablePage> {
  // Sample timetable data - in real app, load from backend
  List<TimeTableEntry> timetable = [
    TimeTableEntry(day: 'Monday', time: '09:00 AM - 10:30 AM', course: 'Discrete Math'),
    TimeTableEntry(day: 'Tuesday', time: '11:00 AM - 12:30 PM', course: 'OOP'),
    TimeTableEntry(day: 'Wednesday', time: '02:00 PM - 03:30 PM', course: 'Database Systems'),
  ];

  Future<TimeTableEntry?> _openEditDialog(TimeTableEntry entry, int index) async {
    final result = await showDialog<TimeTableEntry?>(
      context: context,
      builder: (context) => EditTimeTableDialog(entry: entry),
    );

    if (result != null) {
      setState(() {
        if (index >= 0 && index < timetable.length) {
          timetable[index] = result;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Time table updated successfully!')),
          );
        }
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Teacher Time Table',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: ThemeColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: timetable.isEmpty
            ? Center(
          child: Text(
            'No time table entries found.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
        )
            : ListView.separated(
          itemCount: timetable.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final entry = timetable[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: ThemeColors.primary.withOpacity(0.5), width: 1.5),
              ),
              elevation: 6,
              shadowColor: ThemeColors.primary.withOpacity(0.25),
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                title: Text(
                  entry.course,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ThemeColors.primary,
                  ),
                ),
                subtitle: Text(
                  '${entry.day} | ${entry.time}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: ThemeColors.primary, size: 26),
                  onPressed: () => _openEditDialog(entry, index),
                  tooltip: 'Edit this entry',
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          _openEditDialog(TimeTableEntry(day: '', time: '', course: ''), -1)
              .then((newEntry) {
            if (newEntry != null && newEntry.course.isNotEmpty) {
              setState(() {
                timetable.add(newEntry);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New time table entry added!')),
              );
            }
          });
        },
      ),
    );
  }
}

class TimeTableEntry {
  String day;
  String time;
  String course;
  bool isCancelled;
  String notes;

  TimeTableEntry({
    required this.day,
    required this.time,
    required this.course,
    this.isCancelled = false,
    this.notes = '',
  });

  TimeTableEntry copyWith({
    String? day,
    String? time,
    String? course,
    bool? isCancelled,
    String? notes,
  }) {
    return TimeTableEntry(
      day: day ?? this.day,
      time: time ?? this.time,
      course: course ?? this.course,
      isCancelled: isCancelled ?? this.isCancelled,
      notes: notes ?? this.notes,
    );
  }
}

class EditTimeTableDialog extends StatefulWidget {
  final TimeTableEntry entry;
  const EditTimeTableDialog({super.key, required this.entry});

  @override
  State<EditTimeTableDialog> createState() => _EditTimeTableDialogState();
}

class _EditTimeTableDialogState extends State<EditTimeTableDialog> {
  late TextEditingController courseController;
  late TextEditingController timeController;
  late TextEditingController notesController;
  String? selectedDay;
  bool isCancelled = false;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  void initState() {
    super.initState();
    courseController = TextEditingController(text: widget.entry.course);
    timeController = TextEditingController(text: widget.entry.time);
    notesController = TextEditingController(text: widget.entry.notes);
    selectedDay = widget.entry.day.isNotEmpty ? widget.entry.day : null;
    isCancelled = widget.entry.isCancelled;
  }

  @override
  void dispose() {
    courseController.dispose();
    timeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.85; // 85% of screen width

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dialogWidth),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.entry.course.isEmpty ? 'Add Time Table Entry' : 'Edit Time Table Entry',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: ThemeColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 28),

              // Day Dropdown
              _buildDropdown(),

              const SizedBox(height: 28),

              // Course name
              _buildTextField(controller: courseController, label: 'Course Name'),

              const SizedBox(height: 28),

              // Time input
              _buildTextField(controller: timeController, label: 'Time (e.g. 09:00 - 10:30)'),

              const SizedBox(height: 28),

              // Notes multiline text field
              TextField(
                controller: notesController,
                maxLines: 5,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Notes (optional)',
                  labelStyle: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
              ),

              const SizedBox(height: 28),

              // Cancel class checkbox
              Row(
                children: [
                  Checkbox(
                    value: isCancelled,
                    activeColor: ThemeColors.primary,
                    onChanged: (val) {
                      setState(() {
                        isCancelled = val ?? false;
                      });
                    },
                  ),
                  Text(
                    'Cancel this class',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: ThemeColors.primary,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () => Navigator.pop(context, null),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                      elevation: 4,
                      shadowColor: ThemeColors.primary.withOpacity(0.5),
                    ),
                    onPressed: () {
                      if (selectedDay == null ||
                          courseController.text.trim().isEmpty ||
                          timeController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all required fields')),
                        );
                        return;
                      }
                      Navigator.pop(
                        context,
                        widget.entry.copyWith(
                          day: selectedDay,
                          course: courseController.text.trim(),
                          time: timeController.text.trim(),
                          notes: notesController.text.trim(),
                          isCancelled: isCancelled,
                        ),
                      );
                    },
                    child: const Text('Save',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ThemeColors.primary.withOpacity(0.8), width: 2),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primary.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        value: selectedDay,
        hint: Text(
          'Select Day',
          style: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        dropdownColor: Colors.white,
        iconEnabledColor: ThemeColors.primary,
        style: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w800, fontSize: 18),
        items: days
            .map(
              (day) => DropdownMenuItem(
            value: day,
            child: Text(day, style: TextStyle(color: ThemeColors.primary, fontSize: 18)),
          ),
        )
            .toList(),
        onChanged: (val) {
          setState(() {
            selectedDay = val;
          });
        },
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: ThemeColors.primary, fontWeight: FontWeight.w800),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
