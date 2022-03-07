import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class StudentsStats extends StatefulWidget {

  late var teacher = [];
  late var student;

  StudentsStats(this.teacher, this.student);

  @override
  _StudentsStatsState createState() => _StudentsStatsState();
}

class _StudentsStatsState extends State<StudentsStats> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''),),
      body: Container(),
    );
  }
}