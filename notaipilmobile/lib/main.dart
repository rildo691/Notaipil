import 'package:flutter/material.dart';

/**User Interface*/
import 'package:notaipilmobile/ui/login.dart';
import 'package:notaipilmobile/ui/account_type.dart';
import 'package:notaipilmobile/register/student/student_register.dart';



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
        )
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const Login(),
        '/type': (_) => const AccountType(),
        '/student': (_) => StudentRegister(),
      },
    );
  }
}
