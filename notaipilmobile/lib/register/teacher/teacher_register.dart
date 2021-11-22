import 'package:flutter/material.dart';

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
            page = Container();
            break;
          case '/two':
            page = Container();
            break;
          case '/three':
            page = Container();
            break;
          case '/four':
            page = Container();
            break;
          default:
            return null;
        }

        MaterialPageRoute(builder: (context) => page, settings: settings);
      }
    );
  }
}