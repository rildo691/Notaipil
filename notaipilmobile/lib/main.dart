import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**User Interface*/
import 'package:notaipilmobile/ui/login.dart';
import 'package:notaipilmobile/ui/account_type.dart';
import 'package:notaipilmobile/ui/choose_profile.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Registers */
import 'package:notaipilmobile/register/student/student_register.dart';
import 'package:notaipilmobile/register/teacher/teacher_register.dart';
import 'package:notaipilmobile/register/educator/educator_register.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart' as coordinator;
import 'package:notaipilmobile/dashboards/principal/main_page.dart' as principal;
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
        hintColor: letterColor,
        primaryColor: letterColor,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0D89B0)),
            borderRadius: BorderRadius.circular(5.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0D89B0))
          ),
          hintStyle: TextStyle(color: letterColor),
          filled: true,
          fillColor: fillColor,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: letterColor),
        ),
        dataTableTheme: DataTableThemeData(
          dataRowColor: MaterialStateColor.resolveWith((states) => 
            states.contains(MaterialState.selected) ? backgroundColor : backgroundColor
          ),
          dataTextStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier != null ? SizeConfig.textMultiplier !* 2.3 : 9),
          dividerThickness: 5,
          headingTextStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier != null ? SizeConfig.textMultiplier !* 2.3 : 9),
          headingRowColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) 
            ? borderAndButtonColor: borderAndButtonColor
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
        Locale('pt', ''),
      ],
      routes: {
        '/': (_) => Login(),
        '/type': (_) => const AccountType(),
        '/student': (_) => StudentRegister(),
        '/teacher': (_) => TeacherRegister(),
        '/educator': (_) => EducatorRegister(),
      },
    );
  }
}
