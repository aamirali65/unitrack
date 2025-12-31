import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unitrack/Models/signup_model.dart';

class StudentManager {
  List<SignupModel> students  = [];

  StudentManager(){
    loadstudents();
  }
  Future<void> loadstudents() async{
    final String jsonload = await rootBundle.loadString('assets/student.json');
    final List templist =  json.decode(jsonload);                                //decode data of present json and store in main list

    // => This arrow indicates that for each element e,
    // we are going to perform the action on the right side.
    students = templist.map((e) => SignupModel.fromJson(e)).toList();

  }

  void addStudent(SignupModel student){                                          // add student data from signup page in main list
    students.add(student);
  }

  Future<void> saveStudents() async{
    final saveDir = await getApplicationCacheDirectory();
    final file = File('${saveDir.path}/students_local.json');                    // atlast store all data of students in local app storage

    final jsonData = json.encode(students.map((e) => e.tojson()).toList());

    await file.writeAsString(jsonData);
  }
}
