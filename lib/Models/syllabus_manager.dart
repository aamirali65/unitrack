

import 'package:unitrack/DSA/syllabus_search.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:unitrack/Models/Syllabus_model.dart';

class SyllabusManager{

  static Future<List<SyllabusSearch>>loadCourse() async{

      final String jsonString = await rootBundle.loadString("assets/syllabus.json");
      final Map<String, dynamic> jsondata = jsonDecode(jsonString);

      final List<SyllabusSearch> syllabusList = [];


      jsondata.forEach((courseName, weeksData){

        List<WeekNode> weekList = [];


        weeksData.forEach((weekNumber, syllabusTopic) {
          final int weekInt = int.tryParse(weekNumber) ?? 0;
          weekList.add(
            WeekNode(
              weak: weekInt,
              syllabus: syllabusTopic.toString(),
            ),
          );
        });


        // Sort the weeks
        weekList.sort((WeekNode a,WeekNode b) => a.weak.compareTo(b.weak ));

        syllabusList.add(
          SyllabusSearch(
            courseName: courseName,
            weeks : weekList,
          ),
        );
      });
      return syllabusList;

  }
}
