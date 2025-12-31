import 'package:flutter/cupertino.dart';
import 'package:unitrack/DSA/Customized_Binary.dart';
import 'package:unitrack/Models/Syllabus_model.dart';
class SyllabusSearch {
  final String courseName;
  final List<WeekNode> weeks;     // List of weeks with syllabus of the selected course

  SyllabusSearch({
     required this.courseName,
     required this.weeks,
  });

  WeekNode? searchWeek(int targetWeek){
   int index =  BinarySearch.search(weeks,(week){
                if(week.weak == targetWeek) return 0;
                if(week.weak < targetWeek) return -1;
                return 1;
                },);
    if(index != -1){
      return weeks[index];
    }

  }


}