import 'dart:convert';
import 'package:flutter/services.dart';

class SignDataLoader {
  static Future<bool> login(String id, String password) async {
    final String jsonString =
    await rootBundle.loadString('assets/student.json');

    final List<dynamic> students = jsonDecode(jsonString);

    for (var student in students) {
      if (student['id'] == id &&
          student['password'] == password) {
        return true;
      }
    }
    return false;
  }
}
