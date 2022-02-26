import 'package:flutter/material.dart';

/**Steps to complete the task */
import 'package:notaipilmobile/register/teacher/steps/first_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/second_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/third_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/fourth_page.dart' as teacher;
import 'package:notaipilmobile/register/teacher/steps/fifth_page.dart' as teacher;

class TeacherRegister extends StatefulWidget {

  const TeacherRegister({ Key? key }) : super(key: key);

  @override
  _TeacherRegisterState createState() => _TeacherRegisterState();
}

class _TeacherRegisterState extends State<TeacherRegister> {

   @override
   Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/one',
      onGenerateRoute: (settings){
        var route = settings.name;
        Widget page;
        switch (route) {
          case '/one':
            page = teacher.FifthPage();
            break;
          case '/two':
            page = teacher.FirstPage();
            break;
          case '/three':
            page = teacher.SecondPage();
            break;
          case '/four':
            page = teacher.ThirdPage();
            break;
          case '/fifth':
            page = teacher.FourthPage();
            break;
          default:
            return null;
        }

        return MaterialPageRoute(builder: (context) => page, settings: settings);
      }
    );
  }
}