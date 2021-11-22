import 'package:flutter/material.dart';
import 'package:notaipilmobile/register/student/steps/first_page.dart';

/**Steps to complete the task */
import 'package:notaipilmobile/register/teacher/steps/first_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/second_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/third_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/fourth_page.dart' as teacher;

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

class TeacherRegister extends StatefulWidget {

  const TeacherRegister({ Key? key }) : super(key: key);

  @override
  _TeacherRegisterState createState() => _TeacherRegisterState();
}

class _TeacherRegisterState extends State<TeacherRegister> {

   @override
   Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/one_page',
      onGenerateRoute: (settings){
        var route = settings.name;
        Widget page;
        switch (route) {
          case '/one_page':
            page = teacher.FirstPage();
            break;
          case '/two_page':
            page = teacher.SecondPage();
            break;
          case '/three_page':
            page = teacher.ThirdPage();
            break;
          case '/four_page':
            page = teacher.FourthPage();
            break;
          default:
            return null;
        }

        MaterialPageRoute(builder: (context) => page, settings: settings);
      }
    );
  }
}