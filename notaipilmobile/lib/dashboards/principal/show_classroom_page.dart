import 'package:flutter/material.dart';

class ShowClassroomPage extends StatefulWidget {

  late String classroomId;
  ShowClassroomPage(this.classroomId);

  @override
  _ShowClassroomPageState createState() => _ShowClassroomPageState();
}

class _ShowClassroomPageState extends State<ShowClassroomPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''),),
      body: Container(),
    );
  }
}