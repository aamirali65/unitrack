import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:unitrack/Models/studentmodel.dart';
import '../Models/studentmodel.dart';

class StudentService {
  static Future<Student?> getStudentById(String id) async {
    final String jsonString =
    await rootBundle.loadString("assets/student.json");

    final List<dynamic> data = jsonDecode(jsonString);

    for (var item in data) {
      if (item['id'] == id) {
        return Student.fromJson(item);
      }
    }
    return null;
  }
}
