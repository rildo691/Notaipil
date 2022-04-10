import 'package:flutter/material.dart';

/**Steps to complete the task */
import 'package:notaipilmobile/register/student/steps/first_page.dart';
import 'package:notaipilmobile/register/student/steps/second_page.dart';
import 'package:notaipilmobile/register/student/steps/third_page.dart';
import 'package:notaipilmobile/register/student/steps/fourth_page.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

class StudentRegister extends StatefulWidget {

  const StudentRegister({ Key? key }) : super(key: key);

  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  
  @override
  Widget build(BuildContext context) {
    return  Navigator(
          initialRoute: '/first',
          onGenerateRoute: (settings){
            var route = settings.name;
            Widget page;
            switch (route) {
              case '/first':
                page = FirstPage();
                break;
              case '/second':
                page = SecondPage();
                break;
              case '/third':
                page = ThirdPage();
                break;
              case '/fourth':
                page = FourthPage();
                break;
              default:
                return null;
            }

            return MaterialPageRoute(builder: (context) => page, settings: settings);
          },
        );
  }
}
