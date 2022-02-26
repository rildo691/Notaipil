import 'package:flutter/material.dart';

/**Steps to complete the task */
import 'package:notaipilmobile/register/educator/steps/first_page.dart' as educator;
import 'package:notaipilmobile/register/educator/steps/second_page.dart' as educator;
import 'package:notaipilmobile/register/educator/steps/third_page.dart' as educator;
import 'package:notaipilmobile/register/educator/steps/fourth_page.dart' as educator;

class EducatorRegister extends StatefulWidget {

  const EducatorRegister({ Key? key }) : super(key: key);

  @override
  _EducatorRegisterState createState() => _EducatorRegisterState();
}

class _EducatorRegisterState extends State<EducatorRegister> {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/one',
      onGenerateRoute: (settings){
        var route = settings.name;
        Widget page;
        switch (route) {
          case '/one':
            page = educator.FirstPage();
            break;
          case '/two':
            page = educator.SecondPage();
            break;
          case '/three':
            page = educator.ThirdPage();
            break;
          case '/four':
            page = educator.FourthPage();
            break;
          default:
            return null;
        }

        return MaterialPageRoute(builder: (context) => page, settings: settings);
      }
    );
  }
}