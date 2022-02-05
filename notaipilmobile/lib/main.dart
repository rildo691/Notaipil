import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';

/**User Interface*/
import 'package:notaipilmobile/ui/login.dart';
import 'package:notaipilmobile/ui/account_type.dart';
import 'package:notaipilmobile/ui/choose_profile.dart';

/**Registers */
import 'package:notaipilmobile/register/student/student_register.dart';
import 'package:notaipilmobile/register/teacher/teacher_register.dart';

/**Configurations */
import 'configs/size_config.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart' as coordinator;
import 'package:notaipilmobile/dashboards/teacher/show_coordination.dart' as teacher;
import 'package:notaipilmobile/dashboards/student/profile.dart' as student;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'NotaIPIL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.white,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0D89A4)),
            borderRadius: BorderRadius.circular(5.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0D89A4))
          ),
          hintStyle: TextStyle(color: Colors.white),
        ),
        dataTableTheme: DataTableThemeData(
          dataRowColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Color.fromARGB(255, 34, 42, 55) : Color.fromARGB(255, 34, 42, 55)),
          headingRowColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Color(0xFF0D89A4) : Color(0xFF0D89A4)),
          headingTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.textMultiplier != null && SizeConfig.widthMultiplier != null ?  SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4 : null) ,
          dividerThickness: 5,
          dataTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.textMultiplier != null && SizeConfig.widthMultiplier != null ? SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.2 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4 : null),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => /*Login()*/ student.Profile(),
        '/type': (_) => const AccountType(),
        '/student': (_) => StudentRegister(),
        '/teacher': (_) => TeacherRegister(),
        '/principalDashboard': (_) => MainPage(),
        '/coordinatorDashboard': (_) => coordinator.MainPage(),
      },
    );
  }
}
