import 'dart:convert';
import 'package:flutter/services.dart';
import '../Models/attendance_model.dart';
import '../DSA/Customized_Hashmap.dart';

class AttendanceService {
  static Future<Hash_Map<String, List<AttendanceNode>>> loadattendance() async {

    final jsonString = await rootBundle.loadString('assets/attendance.json');
    // The output of jsonDecode is always a built-in Map, not your custom Hash_Map.
    final Map<String, dynamic> decodedJson = json.decode(jsonString);
    Hash_Map<String, List<AttendanceNode>> attendanceMap = Hash_Map();

    //Iterate over the standard Dart map to populate your custom Hash_Map.
    decodedJson.forEach((key, value) {
      // Ensure the value is treated as a List.
      if (value is List) {
        // Use .map() to convert each item in the list into an AttendanceNode object.
        List<AttendanceNode> nodes = value
            .map((item) => AttendanceNode.fromJson(item))
            .toList();
        attendanceMap.put(key, nodes);
      }
    });

    return attendanceMap;
  }
}
