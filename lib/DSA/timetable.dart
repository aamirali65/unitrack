// Path: lib/DSA/timetable.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:unitrack/DSA/Customized_Queue.dart';

// The class name is already in PascalCase, which is correct.
class Timetable {
  // This instance variable will hold the loaded timetable data.
  Map<String, List<Map<String, String>>> timeTablemap = {};

  // Getter to allow the UI to iterate over the timetable entries.
  Iterable<MapEntry<String, List<Map<String, String>>>> get entries =>
      timeTablemap.entries;

  // Instance method to load timetable data from a JSON file.
  Future<void> loadTimetable() async {
    final String jsonString = await rootBundle.loadString(
        'assets/timetable.json');
    // Assuming your custom HashMap is not needed here as json.decode returns a standard Map.
    final Map<String, dynamic> decodedJson = json.decode(jsonString);

    decodedJson.forEach((key, value) {
      if (value is List) { // Type check for safety
        List<Map<String, String>> lectureList = [];
        for (var lec in value) {
          if (lec is Map) { // Type check for safety
            // Ensure subject and time are converted to String
            lectureList.add({
              "subject": lec["subject"].toString(),
              "time": lec["time"].toString()
            });
          }
        }
        timeTablemap[key] = lectureList; // Load data into the instance variable
      }
    });
  }

  // --- QUEUE LOGIC MOVED INSIDE THE CLASS ---

  // 1. Queue is now an instance variable of the Timetable class.
  // Renamed for clarity and to match your class name.
  cutom_queue<String> queue = cutom_queue();

  // 2. This function checks the front of the queue.
  String? peekFront() {
    // Calling peek() method from your CustomQueue
    return queue.peek();
  }

  // 3. This function loads a list of day names into the queue.
  void loadDays(List<String> values) {
    queue.clear(); // Assuming CustomQueue has a `clear` method.
    for (var val in values) {
      queue.enqueue(val);
    }
  }

  // 4. This function moves today's schedule to the front of the queue.
  void Todaytofront(String today) {
    for (int v = 0; v < queue.size; v++) {
      if (queue.peek() == today) {
        break;
      } else {
        queue.enqueue(queue.dequeue()!);
      }
    }
  }

  // 5. This function converts the queue to a List for the UI to use.
  List<String> toList() {
    // Assuming CustomQueue has a `toList()` method or can be iterated.
    // If not, you need to implement it in your CustomQueue class.
    return queue.tolist();
  }
}
