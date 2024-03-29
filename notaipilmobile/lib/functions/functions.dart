import 'package:flutter/material.dart';
import 'package:notaipilmobile/parts/variables.dart';

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

  Future<List<dynamic>> getSingleTeacher(userEmail) async{
    var teachers = [];
    var response = await helper.get("teachers");

    for (var r in response){
      if (r["teacherAccount"]["email"] == userEmail){
        Map<String, dynamic> map = {
          "id": r["id"],
          "schedule": r["schedule"],
          "teacherAccount": r["teacherAccount"],
        };

        teachers.add(map);
      }
    }

    return teachers;
  }

  Future<List<dynamic>> getAllTeachersByName(value) async{
    var teachers = [];
    var response = await helper.get("teachers");

    for (var r in response){

      if (r["teacherAccount"]["personalData"]["fullName"].toString().toUpperCase().contains(value.toString().toUpperCase())
      || r["teacherAccount"]["personalData"]["bi"].toString().toUpperCase().contains(value.toString().toUpperCase())){
        Map<String, dynamic> map = {
          "id": r["id"],
          "teacherAccount": r["teacherAccount"],
        };

        teachers.add(map);
      }
    }

    return teachers;
  }

  Future<List<dynamic>> getAllTeachersByArea(areaId) async{
    var teachers = [];
    var response = await helper.get("teacher_classrooms/areas/$areaId");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "schedule": r["schedule"],
        "teacherAccount": r["teacherAccount"],
      };

      teachers.add(map);
    }

    return teachers;
  }

  Future<List<dynamic>> getAllTeachersByAreaAndByName(value, areaId) async{
    var teachers = [];
    var response = await helper.get("teacher_classrooms/areas/$areaId");

    for (var r in response){
      if (r["teacherAccount"]["personalData"]["fullName"].toString().toUpperCase().contains(value.toString().toUpperCase()) 
      || r["teacherAccount"]["personalData"]["bi"].toString().toUpperCase().contains(value.toString().toUpperCase())){
        Map<String, dynamic> map = {
          "id": r["id"],
          "schedule": r["schedule"],
          "teacherAccount": r["teacherAccount"],
        };

        teachers.add(map);
      }
    }

    return teachers;
  }

  Future<List<dynamic>> getTeachersClassrooms(id) async{

    var classrooms = [];
    var response = await helper.get("teacher_classrooms/classrooms/teacher/${id}");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
        "room": r["room"],
        "period": r["period"],
        "place": r["place"],
        "code": r["code"],
        "schedule": r["schedule"],
        "gradeId": r["gradeId"],
        "courseId": r["courseId"],
        "academicYear": r["academicYear"],
      };

      classrooms.add(map);
    }

    return classrooms;
  }

  Future<List<dynamic>> getTeacherInClassroom(teacherId, classroomId) async{
    var teacherInClassroom = [];
    var response = await helper.get("teacher_classrooms");

    for (var r in response){

      if (r["teacher"]["id"].toString() == teacherId && r["classroom"]["id"] == classroomId){

        var response2 = await helper.get("subject_course_grade/${r["subjectCourseGradeId"]}");

        Map<String, dynamic> map = {
          "id": r["id"],
          "subject": response2["subject"],
          "classroom": r["classroom"],
          "teacher": r["teacher"]
        };

        teacherInClassroom.add(map);
      }
    }

    return teacherInClassroom;
  }

  Future<List<dynamic>> getTeachersCourses(id) async{
    var courses = [];
    var response = await helper.get("teacher_classrooms/courses/teacher/${id}");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "code": r["code"],
        "name": r["name"],
        "areaId": r["areaId"],
      };

      courses.add(map);
    }

    return courses;

  }

  Future<List<dynamic>> getTeachersStudentsQuantity(id) async{    
    var students = [];
    var quantity = 0;
    var response = await helper.get("teacher_classrooms/students/teacher/${id}");

    for (var r in response){
      quantity += int.parse(r["students"].toString());
    }

    Map<String, dynamic> map = {
      'quantity': quantity,
    };

    students.add(map);

    return students;
  }

  Future<List<dynamic>> getTeachersClassroomsOrganizedByArea(id) async{    
    var response = await helper.get("teacher_classrooms");
    var courseClassroomsCC = [];
    var courseClassroomsQUI = [];
    var courseClassroomsMEC = [];
    var courseClassroomsINF = [];
    var courseClassroomsELEC = [];
    var areas = [];

    var responseArea = await helper.get("areas");
    for (var r in responseArea) {
      Map<String, dynamic> map = {
        'id': r["id"],
        "name": r["name"]
      };

      areas.add(map);
    }


    var areasList = List<dynamic>.generate(areas.length, (index) => 0);
    
      for (var a in areas){
        for (var respons in response){
          if (respons["teacher"]["id"].toString() == id){
            var resp = await helper.get("courses/${respons["subjectCourseGrade"]["courseId"]}");
            if (resp["area"]["id"] == a["id"]){
              var res = await helper.get("subject_course_grade/${respons["subjectCourseGrade"]["id"]}");
              Map<String, dynamic> map = {
                'area': resp["area"]["name"],
                'subjectCourseGrade': res,
                'classroom': respons["classroom"],
              };

              if (a["name"].toString().toUpperCase().contains("CIVIL")){
                courseClassroomsCC.add(map);
              } else if (a["name"].toString().toUpperCase().contains("INF")){
                courseClassroomsINF.add(map);
              } else if (a["name"].toString().toUpperCase().contains("QU")){
                courseClassroomsQUI.add(map);
              } else if (a["name"].toString().toUpperCase().contains("MEC")){
                courseClassroomsMEC.add(map);
              } else if (a["name"].toString().toUpperCase().contains("ELEC")){
                courseClassroomsELEC.add(map);
              }
            }
          }
        }
      }

      for (int i = 0; i < areas.length; i++){
        if (areas[i]["name"].toString().toUpperCase().contains("CIVIL")){
          areasList[i] = courseClassroomsCC;
        } else if (areas[i]["name"].toString().toUpperCase().contains("INF")){
          areasList[i] = courseClassroomsINF;
        } else if (areas[i]["name"].toString().toUpperCase().contains("QU")){
          areasList[i] = courseClassroomsQUI;
        } else if (areas[i]["name"].toString().toUpperCase().contains("MEC")){
          areasList[i] = courseClassroomsMEC;
        } else if (areas[i]["name"].toString().toUpperCase().contains("ELEC")){
          areasList[i] = courseClassroomsELEC;
        }
      }

    return areasList;

/*
    var response = await helper.get("teacher_classrooms/areas/teacher/all/${id}");
    var areas = [];

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
      };

      areas.add(map);
    }

    return areas;*/
  }

  Future<List<dynamic>> getTeacherClassroomsOrganizedByAreaAndCourse(teacherId, areaId) async{
    var response = await helper.get("teacher_classrooms");
    var response2 = await helper.get("courses/areas/$areaId");
    var classrooms = [];

    for (var r in response2){
      for (var t in response){
        if (t["teacher"]["id"] == teacherId){
          if (r["id"] == t["subjectCourseGrade"]["courseId"]){
            var response3 = await helper.get("subject_course_grade/${t["subjectCourseGrade"]["id"]}");

            Map<String, dynamic> map = {
              "course": r["name"],
              "subjectCourseGrade": response3,
              "classroom": t["classroom"],
            };
            classrooms.add(map);
          }
        }
      }
    }

    return classrooms;
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

  Future<List<dynamic>> getAllClassroomsTeachers(classroomId) async{
    var teachers = [];
    var response = await helper.get("teacher_classrooms/classrooms/${classroomId}");

    for (var r in response){
      Map<String, dynamic> map = {
        "teacher": r["teacher"],
        "subject": r["subject"]
      };

      teachers.add(map);
    }

    return teachers;
  }

  Future<List<dynamic>> getClassroomResponsible(classroomId) async{
    var teachers = [];
    var response = await helper.get("teacher_classrooms/classrooms/${classroomId}");

    for (var r in response){
      if (r["teacher"] != null){
        if (r["teacher"]["responsible"]){
          Map<String, dynamic> map = {
            "teacher": r["teacher"],
            "subject": r["subject"],
          };
          
          teachers.add(map);
        }
      }
    }

    return teachers;
  }

  Future<List<dynamic>> getTeachersCoordinations(id) async{
    var coordinations = [];
    var response = await helper.get("teacher_classrooms/areas/teacher/all/$id");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
        'createdAt': r["createdAt"],
        "updatedAt": r["updatedAt"],
      };

      coordinations.add(map);
    }

    return coordinations;
  }

  Future<List<dynamic>> getAllCoordinations({value}) async{
    var coordinations = [];
    var response = await helper.get("coordinations");

    for (var r in response){
      Map<String, dynamic> map = {
        "areaId": r["areaId"],
        "areaName": r["areaName"],
        "courses": r["courses"],
        "classrooms": r["classrooms"],
        "students": r["students"],
        "teachers": r["teachers"],
        "coordinator": r["coordinator"],
        "email": r["email"],
        "avatar": r["avatar"]
      };

      coordinations.add(map);
    }

    return coordinations;
  }

  Future<List<dynamic>> getCoordinatorsByName(value) async{
    var coordinations = [];
    var response = await helper.get("coordinations");

    for (var r in response){
      if (r["coordinator"].toString().toUpperCase().contains(value.toString().toUpperCase())){
        Map<String, dynamic> map = {
          "areaId": r["areaId"],
          "areaName": r["areaName"],
          "courses": r["courses"],
          "classrooms": r["classrooms"],
          "students": r["students"],
          "teachers": r["teachers"],
          "coordinator": r["coordinator"],
          "email": r["email"],
          "avatar": r["avatar"]
        };

        coordinations.add(map);
      }
    }

    return coordinations;
  }

  Future<List<dynamic>> getTeacherAreas(teacherId) async{
    var areas = [];
    var response = await helper.get("teacher_classrooms/areas/teacher/all/$teacherId");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
        "isActive": r["isActive"],
      };
      areas.add(map);
    }

    return areas;
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

  Future<List<dynamic>> getCoordinatorAndArea(userEmail) async{
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

        var response3 = await helper.get("areas/${r["courses"][0]["areaId"]}");

        Map<String, dynamic> map2 = {
        "id": response3["id"],
        "name": response3["name"],
      };

        coordinators.add(map2);
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
        "isEliminated": r["isEliminated"],
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
          "room": ClassroomModel.fromJson(r).room.toString(),
          "period": ClassroomModel.fromJson(r).period.toString(),
          "place": ClassroomModel.fromJson(r).place.toString(),
          "code": ClassroomModel.fromJson(r).code.toString(),
          "schedule": r["schedule"],
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

      var response2 = await helper.get("grades/${r["gradeId"]}");

      Map<String, dynamic> map = {
        "id": ClassroomModel.fromJson(r).id.toString(),
        "name": ClassroomModel.fromJson(r).name.toString(),
        "room": ClassroomModel.fromJson(r).room.toString(),
        "period": ClassroomModel.fromJson(r).period.toString(),
        "place": ClassroomModel.fromJson(r).place.toString(),
        "schedule": r["schedule"],
        "grade": response2,
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
          "schedule": r["schedule"],
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
          "schedule": response["schedule"],
          "place": response["place"],
          "course": response["course"]
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
          "room": ClassroomModel.fromJson(r).room.toString(),
          "period": ClassroomModel.fromJson(r).period.toString(),
          "place": ClassroomModel.fromJson(r).place.toString(),
          "code": ClassroomModel.fromJson(r).code.toString(),
          "grade": r["grade"],
        };
        
        classrooms.add(map);
      }
    }

    return classrooms;
  }

  Future<List<dynamic>> getClassroomsByCourseAndName(name) async{
    var classrooms = [];
    var response = await helper.get("classrooms");

    for (var r in response){
      if (r["name"].toString().toUpperCase().contains(name.toString().toUpperCase())){
        Map<String, dynamic> map = {
          "id": ClassroomModel.fromJson(r).id.toString(),
          "name": ClassroomModel.fromJson(r).name.toString(),
          "room": ClassroomModel.fromJson(r).room.toString(),
          "period": ClassroomModel.fromJson(r).period.toString(),
          "place": ClassroomModel.fromJson(r).place.toString(),
          "code": ClassroomModel.fromJson(r).code.toString(),
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

  Future<List<dynamic>> getQualificationsByArray(teachers) async{
    var qualifications = [];

    for (var t in teachers){
      var response = await helper.get("qualifications/${t["teacherAccount"]["qualificationId"]}");

      Map<String, dynamic> map = {
        "id": QualificationsModel.fromJson(response).id,
        "name": QualificationsModel.fromJson(response).name,
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

<<<<<<< HEAD
  Future<List<dynamic>> getSingleClassroomStudent(studentId) async{
    var student = [];
    var response = await helper.get("classroom_students/students");

    for (var r in response){
      if (r["studentId"] == studentId){
        Map<String, dynamic> map = {
          "id": r["id"],
          "number": r["number"],
          "student": r["student"],
          "classroom": r["classroom"]
        };

        student.add(map);
      }
    }

    return student;
  }

  Future<List<dynamic>> getSingleStudent(userId, typeAccountId) async{
    var student = [];

    Map<String, dynamic> body = {
      'userId': userId,
      'typeaccountId': typeAccountId,
    };

    var response = await helper.post("users/my_datas", body);

    var response2 = await helper.get("classroom_students");

    for (var r in response2){
      if (r["studentId"] == response["studentId"]){
        var response3 = await helper.get("quarters");
        for (var res in response3){
          if (res["isActive"]){
            Map<String, dynamic> map = {
              "id": response["id"],
              "email": response["email"],
              "telephone": response["telephone"],
              "studentId": response["studentId"],
              "student": response["student"],
              "number": r["number"],
              "classroomStudentId": r["id"],
              "classroom": r["classroom"],
              "quarterId": res["id"],
            };

            student.add(map);
          }
        }
      }
=======
  Future<List<dynamic>> getSingleStudent(userId, typeAccountId) async{
    var student = [];
    var response = await helper.get("users/my_datas");

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "email": r["email"],
        "telephone": r["telephone"],
        "studentId": r["studentId"],
        "student": r["student"],
      };

      student.add(map);
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
    }

    return student;
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

<<<<<<< HEAD
  Future<int> getAllStudentSubjectsLength(studentId) async{
    int length;
    var response = await helper.get("classroom_students/qtd_subjects/$studentId");

    length = int.parse(response.toString());

    return length;
  }

  Future<int> getAllStudentTeachersLength(studentId) async{
    int length;
    var response = await helper.get("classroom_students/qtd_teachers/$studentId");

    length = int.parse(response.toString());

    return length;
  }

  Future<int> getAllStudentStudentsLength(studentId) async{
    int length;
    var response = await helper.get("classroom_students/qtd_students/$studentId");

    length = int.parse(response.toString());

    return length;
  }


=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
  Future<List<dynamic>> getStudentsFaults(studentId) async{
    var response = await helper.get("presences/statistic_classroom_student/${studentId}");
    var presences = [];

    for (var r in response){
      Map<String, dynamic> map = {
        'name': r["name"],
        "quarterId": r["quarterId"],
        "faults": r["faults"],
      };

      presences.add(map);
    }

    return presences;
  }

  Future<List<dynamic>> getStudentsFaultsByQuarter(studentId, quarterId) async{
    var response = await helper.get("presences/statistic_classroom_student/${studentId}");
    var presences = [];

    for (var r in response){
      if (r["quarterId"] == quarterId){
        Map<String, dynamic> map = {
          'name': r["name"],
          "quarterId": r["quarterId"],
          "faults": r["faults"],
        };

        presences.add(map);
      }
    }

    return presences;
  }

  Future<List<dynamic>> getStudentsFaultsByQuarterAndSubject(studentId, quarterId, teacherSubject) async{
    var response = await helper.get("presences/statistic_classroom_student/${studentId}");
    var presences = [];

    for (var r in response){
      if (r["quarterId"] == quarterId && r["name"] == teacherSubject){
        Map<String, dynamic> map = {
          'name': r["name"],
          "quarterId": r["quarterId"],
          "faults": r["faults"],
        };

        presences.add(map);
      }
    }

    return presences;
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
            "avatar": r["avatar"],
          };          

          requests.add(map);
    }
    return requests;
  }

  Future<List<dynamic>> getAdmissionRequestByName(value) async{
    var requests = [];
    var response = await helper.get("teacher_accounts/admission");

    for (var r in response){
      if (r["personalData"]["fullName"].toString().toUpperCase().contains(value.toString().toUpperCase())
      || r["personalData"]["bi"].toString().toUpperCase().contains(value.toString().toUpperCase())){
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
          "avatar": r["avatar"],
        };          

        requests.add(map);
      }
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
            "avatar": response2["avatar"],
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

  void signOut(){
    
  }

  Future<List<dynamic>> getQuarter() async{
    var response = await helper.get("quarters");
    var quarters = [];

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "name": r["name"],
        "isActive": r["isActive"],
		    "permission": r["permission"],
      };

      quarters.add(map);
    }

    return quarters;
  }

  Future<List<dynamic>> getActiveQuarter() async{
    var response = await helper.get("quarters");
    var quarters = [];

    for (var r in response){
<<<<<<< HEAD
      if (r["isActive"]){
=======
      if (r["isActive"] == true){
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
        Map<String, dynamic> map = {
          "id": r["id"],
          "name": r["name"],
          "isActive": r["isActive"],
		      "permission": r["permission"],
        };
        quarters.add(map);
      }
    }

    return quarters;
  }

  Future<List<dynamic>> getInformations(userId, typeAccountId) async{
    Map<String, dynamic> body = {
      'userId': userId,
      'typeAccountId': typeAccountId,
    };
    var informations = [];

    var response = await helper.post("informations/info-user-all", body);

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "title": r["title"],
        "description": r["description"],
        "createdAt": r["createdAt"],
        "fullName": r["fullName"],
        "avatar": r["avatar"],
        "isSeen": r["isSeen"],
        "sent": r["sent"]
      };

      informations.add(map);
    }

    return informations;
  }

  Future<List<dynamic>> getInformationsOne(informationId, sent) async{
    Map<String, dynamic> body = {
      "informationId": informationId,
      "sent": sent,
    };
    var informations = [];

    var response = await helper.post("informations/info-user-one", body);

    if (sent){
      Map<String, dynamic> map = {
        "id": response["id"],
        "fullName": response["fullName"],
        "avatar": response["avatar"],
        "account": response["account"],
        "createdAt": response["createdAt"],
        "title": response["title"],
        "description": response["description"],
        "typeDestiny": response["typeDestiny"],
        "receptors": response["receptors"]
      };

      informations.add(map);
    }
    else {
      Map<String, dynamic> map = {
        "id": response["id"],
        "fullName": response["fullName"],
        "avatar": response["avatar"],
        "account": response["account"],
        "createdAt": response["createdAt"],
        "title": response["title"],
        "description": response["description"],
        "typeDestiny": response["typeDestiny"],
        "isSeen": response["isSeen"]
      };

      informations.add(map);
    }

    return informations;
  }

  Future<List<dynamic>>? getEducators(userId) async{
    Map<String, dynamic> body = {
      'userId': userId,
    };
    var educators = [];
    var response = await helper.post("informations/info-user-educator", body);

    for (var r in response){
      Map<String, dynamic> map = {
        "email": r["email"],
        "fullName": r["fullName"],
        "telephone": r["telephone"],
        "avatar": r["avatar"],
        "bi": r["bi"],
        "student": r["student"],
      };

      educators.add(map);
    }

    return educators;
  }

  Future<List<dynamic>>? getEducatorsByName(userId, name) async{
    Map<String, dynamic> body = {
      'userId': userId,
    };
    var educators = [];
    var response = await helper.post("informations/info-user-educator", body);

    for (var r in response){
      if (r['fullName'].toString().toUpperCase().contains(name.toString().toUpperCase())){
        Map<String, dynamic> map = {
          "email": r["email"],
          "fullName": r["fullName"],
          "telephone": r["telephone"],
          "avatar": r["avatar"],
          "bi": r["bi"],
          "student": r["student"],
        };

        educators.add(map);
      }
    }

    return educators;
  }

  Future<List<dynamic>>? getStudentsByResponsibleId(userId) async{
    Map<String, dynamic> body = {
      'userId': userId,
    };
    var students = [];
    var response = await helper.post("informations/info-user-student", body);

    for (var r in response){
      Map<String, dynamic> map = {
        "id": r["id"],
        "email": r["email"],
        "telephone": r["telephone"],
        "studentId": r["studentId"],
        "student": r["student"],
      };

      students.add(map);
    }

    return students;
  }

  Future<List<dynamic>>? getStudentsNameByResponsibleId(userId, name) async{
    Map<String, dynamic> body = {
      'userId': userId,
    };
    var students = [];
    var response = await helper.post("nformations/info-user-student", body);

    for (var r in response){
      if (r["student"]["personalData"]["fullName"].toString().toUpperCase().contains(name.toString().toUpperCase())){
        Map<String, dynamic> map = {
          "id": r["id"],
          "email": r["email"],
          "telephone": r["telephone"],
          "studentId": r["studentId"],
          "student": r["student"],
        };

        students.add(map);
      }
    }

    return students;
  }

  Future<int> getUnreadInformations(userId, typeAccoundId) async{
    Map<String, dynamic> body = {
      'userId': userId,
      'typeAccountId': typeAccoundId,
    };
    var length;
    var response = await helper.post("informations/info-user-length", body);

    length = response;

    return length;
  }

  Future setReadInformation(userId, informationId) async{
    Map<String, dynamic> body = {
      'userId': userId,
      'informationId': informationId, 
    };

    var response = await helper.patch("informations/info-user-change", body);
    return response;
  }

  Future logOut(context, token){
    return Navigator.pushNamed(context, '/login');
  }

  Future getSchedule(schedule) async{
    var pdf = await helper.get(Uri.parse(baseScheduleUrl + schedule).toString());
    return pdf;
  }

  Future<List<dynamic>> getStudentScoresByQuarter(classroomStudentId, quarterId, classroomId) async{
    var scores = [];
    var response = await helper.get("teacher_classrooms/classrooms/teacher/mini_agenda/$classroomId/$quarterId");

    if (quarterId != null){
      for (var r in response){
        for (int i = 0; i < r["miniAgenda"].length; i++){
          if (r["miniAgenda"][i]["classroomStudentId"] == classroomStudentId){
            Map<String, dynamic> map = {
              "id": r["teacher"]["id"],
              "classroomId": r["teacher"]["classroomId"],
              "subjectCourseGradeId": r["teacher"]["subjectCourseGradeId"],
              "teacher": r["teacher"]["teacher"],
              "miniAgenda": [
                {
                  "id": r["miniAgenda"][i]["id"],
                  "mac": r["miniAgenda"][i]["mac"],
                  "pp": r["miniAgenda"][i]["pp"],
                  "pt": r["miniAgenda"][i]["pt"],
                  "mt": r["miniAgenda"][i]["mt"],
                  "mf": r["miniAgenda"][i]["mf"],
                  "quarterId": r["miniAgenda"][i]["quarterId"],
                  "teacherInClassroomId": r["miniAgenda"][i]["teacherInClassroomId"],
                  "classroomStudentId": r["miniAgenda"][i]["classroomStudentId"],
                }
              ],
              "subject": r["subject"],
            };

            scores.add(map);
          }
        }
        
      }

      return scores;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getClassroomScoresByQuarterAndSubject(quarterId, classroomId) async{
    var scores = [];
    var response = await helper.get("teacher_classrooms/classrooms/teacher/mini_agenda/$classroomId/$quarterId");

    if (quarterId != null){
      for (var r in response){
        int sum = 0;
        int cont = 0;
        for (int i = 0; i < r["miniAgenda"].length; i++){
          if (r["miniAgenda"][i]["mt"] != null){
            sum += int.parse(r["miniAgenda"][i]["mt"].toString());
            cont++;
          }
        }

        Map<String, dynamic> map = {
          'subject': r["subject"],
          "classroom": sum / cont,
        };

        scores.add(map);
      }

      return scores;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getStudentScoresByTeacherAndQuarter (teacherInClassroomId, quarterId, classroomStudentId) async{
    var scores = [];
    var response = await helper.get("mini_agendas/$teacherInClassroomId/$quarterId");

    if (quarterId != null){
      for (var r in response){
        if (r["classroomStudentId"] == classroomStudentId){
          Map<String, dynamic> map = {
            'id': r["id"],
            "mac": r["mac"],
            "pp": r["pp"],
            "pt": r["pt"],
            "mt": r["mt"],
            "mf": r["mf"],
            "classroomStudent": r["classroomStudent"],
          };

          scores.add(map);
        }
      }

      return scores;

    } else {
      return [];
    }
  }