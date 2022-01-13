import 'package:flutter/material.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Models */
import 'package:notaipilmobile/register/model/areaModel.dart';
import 'package:notaipilmobile/register/model/courseModel.dart';
import 'package:notaipilmobile/register/model/gradeModel.dart';
import 'package:notaipilmobile/register/model/classroomModel.dart';
import 'package:notaipilmobile/register/model/qualificationsModel.dart';

ApiService helper = ApiService();

  Future<List<dynamic>> getAreas() async{
    var areas = [];
    var response = await helper.get("areas");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": AreaModel.fromJson(r).id.toString(),
        "name": AreaModel.fromJson(r).name.toString(),
      };

      areas.add(map);
    }

    return areas;
  }

  Future<List<dynamic>> getCoursesName(areas) async{
    var courses = [];
    var response = await helper.get("courses");

    for (var r in response){
      if (CourseModel.fromJson(r).area!.id.toString() == areas){
        Map<String, dynamic> map = {
          "id": CourseModel.fromJson(r).id.toString(),
          "name": CourseModel.fromJson(r).name.toString(),
        };

        courses.add(map);
      }
    }

    return courses;
  }

  Future<List<dynamic>> getCoursesCode(areas) async{
    var courses = [];
    var response = await helper.get("courses");

    for (var r in response){
      if (CourseModel.fromJson(r).area!.id.toString() == areas){
        Map<String, dynamic> map = {
          "id": CourseModel.fromJson(r).id.toString(),
          "code": CourseModel.fromJson(r).code.toString(),
        };
        courses.add(map);
      }
    }

    return courses;
  }

  Future<List<dynamic>> getGrade() async{
    var grades = [];
    var response = await helper.get("grades");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": GradeModel.fromJson(r).id.toString(),
        "name": GradeModel.fromJson(r).name.toString(),
      };

      grades.add(map);
    }

    return grades;
  }
    
  Future<List<dynamic>> getClassroom(course, grade) async{
    var classrooms = [];
    var response = await helper.get("classrooms");

    for (var r in response){
      if (ClassroomModel.fromJson(r).courseId == course && ClassroomModel.fromJson(r).gradeId == grade){
        Map<String, dynamic> map = {
          "id": ClassroomModel.fromJson(r).id.toString(),
          "name": ClassroomModel.fromJson(r).name.toString(),
        };
        
        classrooms.add(map);
      }
    }

    return classrooms;
  }

  Future<List<dynamic>> getQualifications() async{
    var qualifications = [];
    var response = await helper.get("qualifications");

    for(var r in response){
      Map<String, dynamic> map = {
        "id": QualificationsModel.fromJson(r).id,
        "name": QualificationsModel.fromJson(r).name,
      };

      qualifications.add(map);
    }

    return qualifications;
  }
