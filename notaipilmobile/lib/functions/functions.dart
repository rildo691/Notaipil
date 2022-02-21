import 'package:flutter/material.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Models */
import 'package:notaipilmobile/register/model/areaModel.dart';
import 'package:notaipilmobile/register/model/courseModel.dart';
import 'package:notaipilmobile/register/model/courseModelNoArea.dart';
import 'package:notaipilmobile/register/model/gradeModel.dart';
import 'package:notaipilmobile/register/model/classroomModel.dart';
import 'package:notaipilmobile/register/model/qualificationsModel.dart';
import 'package:notaipilmobile/register/model/classroomStudentModel.dart';
import 'package:notaipilmobile/register/model/student.dart';

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

  Future<List<dynamic>> getAreaById(area) async {
    var areas = [];
    var response = await helper.get("areas/$area");

      Map<String, dynamic> map = {
        "id": response["id"],
        "name": response["name"],
      };

      areas.add(map);

    return areas;
  }

  Future<List<dynamic>> getAllTeachers() async{
    var teachers = [];
    var response = await helper.get("teachers");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "teacherAccount": r["teacherAccount"],
      };

      teachers.add(map);
    }

    return teachers;
  }

  Future<List<dynamic>> getTeachersByClassroom(classroom) async{
    var teachers = [];
    var response = await helper.get("teacher_classrooms");

    for (var r in response){
      if(r["classroomId"] == classroom){
        Map<String, dynamic> map = {
          "id": r["id"],
          "responsible": r["responsible"],
          "classroom": r["classroom"],
          "subjectCourseGrade": r["subjectCourseGrade"],
          "teacher": r["teacher"],
        };

        teachers.add(map);

        var response2 = await helper.get("subjects/${r["subjectCourseGrade"]["subjectId"]}");

        Map<String, dynamic> map2 = {
          "subjectId": response2["id"],
          "subjectName": response2["name"],
        };

        teachers.add(map2);
      }
    }

    return teachers;
  }

  Future<List<dynamic>> getAllCoordinations({value}) async{
    var coordinations = [];
    var response = await helper.get("coordinations");

    for (var r in response){
      Map<String, dynamic> map = {
        "areaId": r["areaId"],
        "areaName": r["areaName"],
        "coordinator": r["coordinator"],
      };

      coordinations.add(map);
    }

    return coordinations;
  }

  Future<List<dynamic>> getCoordinatiorsByArea(areaId) async{
    var coordinators = [];
    var response = await helper.get("coordinators/areas/$areaId");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "teacherAccountId": r["teacherAccountId"],
        "courses": r["courses"],
        "teacherAccount": r["teacherAccount"],
      };

      coordinators.add(map);
    }

    return coordinators;
  }

  Future<List<dynamic>> getCoordinator(userEmail) async{
    var coordinators = [];
    var response = await helper.get("coordinators");

    for (var r in response){
      if (r["teacherAccount"]["email"] == userEmail){

        var teacherAccountId = r["teacherAccountId"];
        var response2 = await helper.get("teacher_accounts/$teacherAccountId");

        Map<String, dynamic> map = {
          "id": r["id"],
          "teacherAccountId": r["teacherAccountId"],
          "courses": r["courses"],
          "teacherAccount": r["teacherAccount"],
          "personalData": response2["personalData"],
          "qualification": response2["qualification"],
        };

        coordinators.add(map);
      }
    }

    return coordinators;
  }

  Future<List<dynamic>> getStudentGenderByArea(area) async{
    var studentGender = [];
    var response = await helper.get("classrooms/statistic_gender/areas/${area}");

    for (var r in response){
      Map<String, dynamic> map = {
        "name": r["name"],
        "m": r["m"],
        "f": r["f"],
      };

      studentGender.add(map);
    }

    return studentGender;
  }

  Future<List<dynamic>> getSubjectById(subject) async{
    var subjects = [];
    var response = await helper.get("subject/${subject}");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
        "category": r["category"],
        "code": r["code"],
      };

      subjects.add(map);
    }

    return subjects;
  }

  Future<List<dynamic>> getSubjectByArea(area) async{
    var subjects = [];
    var response = await helper.get("classrooms/subject_course_grade/areas/${area}");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
      };

      subjects.add(map);
    }

    return subjects;
  }

  Future<List<dynamic>> getSubjectByCourseAndGrade(course, grade) async{
    var subjects = [];
    var response = await helper.get("subject_course_grade/classrooms/$course/$grade");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "gradeId": r["gradeId"],
        "courseId": r["courseId"],
        "subjectId": r["subjectId"],
        "subject": r["subject"],
      };

      subjects.add(map);
    }

    return subjects;
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

  Future<List<dynamic>> getCoursesByArea(area) async{
    var courses = []; 
    var response = await helper.get("courses/areas/$area");

    for (var r in response){
        Map<String, dynamic> map = {
          "id": CourseModelNoArea.fromJson(r).id.toString(),
          "code": CourseModelNoArea.fromJson(r).code.toString(),
        };
        courses.add(map);
    }

    return courses;
  }

  Future<List<dynamic>> getCourseById(course) async{
    var courses = []; 
    var response = await helper.get("courses/$course");

        Map<String, dynamic> map = {
          "id": CourseModelNoArea.fromJson(response).id.toString(),
          "code": CourseModelNoArea.fromJson(response).code.toString(),
        };

        courses.add(map);

        return courses;
  }

  Future<List<dynamic>> getAllCourses() async{
    var courses = [];
    var response = await helper.get("courses");

    for (var r in response){
        Map<String, dynamic> map = {
          "id": CourseModel.fromJson(r).id.toString(),
          "name": CourseModel.fromJson(r).name.toString(),
        };
        courses.add(map);
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

  Future<List<dynamic>> getGradeById(grade) async{
    var grades = [];
    var response = await helper.get("grades/$grade");

      Map<String, dynamic> map = {
        "id": GradeModel.fromJson(response).id.toString(),
        "name": GradeModel.fromJson(response).name.toString(),
      };

      grades.add(map);
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

  Future<List<dynamic>> getClassroomsByArea(area) async{
    var classrooms = [];
    var response = await helper.get("classrooms/areas/${area}");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": ClassroomModel.fromJson(r).id.toString(),
        "name": ClassroomModel.fromJson(r).name.toString(),
        "gradeId": ClassroomModel.fromJson(r).gradeId.toString(),
        "courseId": ClassroomModel.fromJson(r).courseId
      };

      classrooms.add(map);
    }

    return classrooms;
  }

  Future<List<dynamic>> getAllClassrooms() async{
    var classrooms = [];
    var response = await helper.get("classrooms");

    for (var r in response){
      
        Map<String, dynamic> map = {
          "id": ClassroomModel.fromJson(r).id.toString(),
          "name": ClassroomModel.fromJson(r).name.toString(),
        };
        
        classrooms.add(map);
    }

    return classrooms;
  }

  Future<List<dynamic>> getClassroomById(classroomId) async{
    var classroom = [];
    var response = await helper.get("classrooms/$classroomId");

        Map<String, dynamic> map = {
          "id": response["id"],
          "name": response["name"],
          "room": response["room"],
          "period": response["period"],
          "code": response["code"],
          "place": response["place"],
        };

        classroom.add(map);

    return classroom;
  }

  Future<List<dynamic>> getClassroomsByCourse(course) async{
    var classrooms = [];
    var response = await helper.get("classrooms");

    for (var r in response){
      if (r["courseId"] == course){
        Map<String, dynamic> map = {
          "id": ClassroomModel.fromJson(r).id.toString(),
          "name": ClassroomModel.fromJson(r).name.toString(),
          "grade": r["grade"],
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

  Future<List<dynamic>> getClassroomStudent(classroom) async{
    var students = [];
    var response = await helper.get("classroom_students/students/${classroom}");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "number": r["number"],
        "student": r["student"],
        "classroom": r["classroom"]
      };

      if (students.length < 3){
        students.add(map);
      }
    }

    return students;
  }

  Future<List<dynamic>> getAllClassroomStudents(classroom) async{
    var students = [];
    var response = await helper.get("classroom_students/students/${classroom}");

    for (var r in response){

      Map<String, dynamic> map = {
        "id": r["id"],
        "number": r["number"],
        "student": r["student"],
        "classroom": r["classroom"]
      };
      
      students.add(map);
    }

    return students;
  }

  Future<List<dynamic>> getAllClassroomsStudentsGender(classroom) async{
    int male = 0;
    int female = 0;
    var response = await helper.get("classroom_students");

    for (var r in response){
      if (ClassroomStudentModel.fromJson(r).classroomId == classroom){
        var studentProcess = ClassroomStudentModel.fromJson(r).studentId;
        var student = await helper.get("students/$studentProcess");

        if (student["data"]["personalData"]["gender"] == "M"){
          male++;
        } else {
          female++;
        }
          
      }
    }

    return [male, female];
  }

  Future<List<dynamic>> getClassroomGender(classroom) async{
    var gender = [];
    var response = await helper.get("classrooms/statistic_gender/classrooms/${classroom}");

    Map<String, dynamic> map = {
      "m": response["m"],
      "f": response["f"]
    };

    gender.add(map);

    return gender;
  }

  Future<List<dynamic>> getAllStudents() async{
    var students = [];
    var response = await helper.get("students");

    for (var r in response){

          Map<String, dynamic> map = {
            "process": Student.fromJson(r).process,
            "fullName": Student.fromJson(r).fullName,
            "gender": Student.fromJson(r).gender,
          };

          students.add(map);
    }

    return students;
  }

  Future<List<dynamic>> getAdmissionRequests() async{
    var requests = [];
    var response = await helper.get("teacher_accounts/admission");

    for (var r in response){

          Map<String, dynamic> map = {
            "id": r["id"],
            "email": r["email"],
            "telephone": r["telephone"],
            "regime": r["regime"],
            "ipilDate": r["ipilDate"],
            "educationDate": r["educationDate"],
            "category": r["category"],
            "createdAt": r["createdAt"],
            "personalData": r["personalData"],
            "qualification": r["qualification"],
          };

          requests.add(map);
    }

    return requests;
  }

  Future<List<dynamic>> getPrincipal(userEmail) async{
    var principal = [];
    var response = await helper.get("directors");

    for (var r in response){
      if (r["teacherAccount"]["email"] == userEmail){
        Map<String, dynamic> map = {
          "id": r["id"],
          "title": r["title"],
        };

        principal.add(map);

        var teacherAccountId = r["teacherAccount"]["id"];
        var response2 = await helper.get("teacher_accounts/$teacherAccountId");

        
          Map<String, dynamic> map2 = {
            "teacherId": response2["id"],
            "email": response2["email"],
            "telephone":response2["telephone"],
            "regime": response2["regime"],
            "ipilDate": response2["ipilDate"],
            "educationDate": response2["educationDate"],
            "category": response2["category"],
            "personalData": response2["personalData"],
            "qualification": response2["qualification"],
          };

        principal.add(map2);
      }
    }
    return principal;
  }

   Future<List<dynamic>> getAllPrincipals() async{
    var principal = [];
    var response = await helper.get("directors");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "title": r["title"],
        "teacherAccount": r["teacherAccount"],
      };

      principal.add(map);
    }
    return principal;
  }