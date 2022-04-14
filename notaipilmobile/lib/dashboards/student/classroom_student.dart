import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/register/model/areaModel.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:badges/badges.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/student/student_grades.dart';
import 'package:notaipilmobile/dashboards/student/classroom_schedule.dart';

class ClassroomStudent extends StatefulWidget {

  late var student = [];

  ClassroomStudent(this.student);

  @override
  _ClassroomStudentState createState() => _ClassroomStudentState();
}

class _ClassroomStudentState extends State<ClassroomStudent> {

  int _selectedIndex = 1;
  int informationLength = 0;
  int quantPositivas = 0;
  int quantNegativas = 0;
  int quantDisciplinas = 0;

  double percPositivas = 1;
  double percNegativas = 1;

  var teacher = [];
  var teachers = [];
  var quarters = [];
  var scores = [];
  var quarterId;

  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;

  List<Map<dynamic, dynamic>> data = [];
  List<charts.Series<StudentsStats, String>> series = [];
  List<StudentsStats> studentData = [];
  List<charts.Series> seriesList = [];

  @override
  void initState() {
    
    super.initState();

    getUnreadInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
              ),
              drawer: new Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: borderAndButtonColor,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: new Text(widget.student[0]["student"]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        accountEmail: new Text(widget.student[0]["student"]["personalData"]["gender"] == "M" ? "Aluno" : "Aluna", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        currentAccountPicture: new ClipOval(
                          child: widget.student[0]["student"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.student[0]["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.student[0]["student"]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: borderAndButtonColor,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Informações', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations()))
                        },
                        trailing: informationLength > 0 ?
                          Badge(
                            toAnimate: false,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.red,
                            badgeContent: Text(informationLength.toString(), style: TextStyle(color: Colors.white),),
                          ) :
                          Container(
                            width: 20,
                            height: 20,
                          ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.power_settings_new_sharp, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Sair', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => null,
                      ),
                      ListTile(
                        leading: Icon(Icons.help_outline, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Ajuda', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => null,
                      )
                    ]
                  )
                )
              ),
              body: SingleChildScrollView(
                child: FutureBuilder(
                    future: Future.wait([getClassroomResponsible(widget.student[0]["classroom"]["id"]), getStudentScoresByQuarter(widget.student[0]["classroomStudentId"], quarterId, widget.student[0]["classroom"]["id"]), getQuarter(), getAllClassroomsTeachers(widget.student[0]["classroom"]["id"])]),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                                strokeWidth: 5.0,
                              ),
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                              teacher = (snapshot.data! as List)[0];
                              scores = (snapshot.data! as List)[1];
                              quarters = (snapshot.data! as List)[2];
                              teachers = (snapshot.data! as List)[3];

                              if (_selected1) {
                              data.clear();
                              quantPositivas = 0;
                              quantNegativas = 0;
                              quantDisciplinas = 0;
                              percPositivas = 1;
                              percNegativas = 1;
                              for (int i = 0; i < scores.length; i++){

                                if (scores[i]["miniAgenda"][0]["mac"] != null){
                                  quantDisciplinas++;
                                  if (scores[i]["miniAgenda"][0]["mac"] > 10){
                                    quantPositivas++;
                                  } else {
                                    quantNegativas++;
                                  }
                                }

                                Map<dynamic, dynamic> map = {
                                  'subject': scores[i]["subject"]["subject"]["code"],
                                  'grade': scores[i]["miniAgenda"][0]["mac"] ?? 0,
                                };
                                data.add(map);
                              }

                              percPositivas = (quantPositivas * 100) / quantDisciplinas;
                              percNegativas = (quantNegativas * 100) / quantDisciplinas;

                              studentData = data.map((e) => 
                                StudentsStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5)),
                              ).toList();

                              series = [
                                charts.Series(
                                  data: studentData,
                                  id: 'Estatísticas do Estudante',
                                  domainFn: (StudentsStats stats, _) => stats.subject,
                                  measureFn: (StudentsStats stats, _) => stats.grade,
                                  colorFn: (StudentsStats stats, _) => charts.ColorUtil.fromDartColor(stats.color),
                                )
                              ];

                            } else if (_selected2){
                              data.clear();
                              quantPositivas = 0;
                              quantNegativas = 0;
                              quantDisciplinas = 0;
                              percPositivas = 1;
                              percNegativas = 1;
                              for (int i = 0; i < scores.length; i++){

                                if (scores[i]["miniAgenda"][0]["pp"] != null){
                                  if (scores[i]["miniAgenda"][0]["pp"] > 10){
                                    quantPositivas++;
                                  } else {
                                    quantNegativas++;
                                  }
                                }

                                Map<dynamic, dynamic> map = {
                                  'subject': scores[i]["subject"]["subject"]["code"],
                                  'grade': scores[i]["miniAgenda"][0]["pp"] ?? 0,
                                };
                                data.add(map);
                              }

                              percPositivas = (quantPositivas * 100) / quantDisciplinas;
                              percNegativas = (quantNegativas * 100) / quantDisciplinas;

                              studentData = data.map((e) => 
                                StudentsStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5)),
                              ).toList();

                              series = [
                                charts.Series(
                                  data: studentData,
                                  id: 'Estatísticas do Estudante',
                                  domainFn: (StudentsStats stats, _) => stats.subject,
                                  measureFn: (StudentsStats stats, _) => stats.grade,
                                  colorFn: (StudentsStats stats, _) => charts.ColorUtil.fromDartColor(stats.color),
                                )
                              ];

                            } else if (_selected3){
                              data.clear();
                              quantPositivas = 0;
                              quantNegativas = 0;
                              quantDisciplinas = 0;
                              percPositivas = 1;
                              percNegativas = 1;
                              for (int i = 0; i < scores.length; i++){

                                if (scores[i]["miniAgenda"][0]["pt"] != null){
                                  if (scores[i]["miniAgenda"][0]["pt"] > 10){
                                    quantPositivas++;
                                  } else {
                                    quantNegativas++;
                                  }
                                }

                                Map<dynamic, dynamic> map = {
                                  'subject': scores[i]["subject"]["subject"]["code"],
                                  'grade': scores[i]["miniAgenda"][0]["pt"] ?? 0,
                                };
                                data.add(map);
                              }

                              percPositivas = (quantPositivas * 100) / quantDisciplinas;
                              percNegativas = (quantNegativas * 100) / quantDisciplinas;

                              studentData = data.map((e) => 
                                StudentsStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5)),
                              ).toList();

                              series = [
                                charts.Series(
                                  data: studentData,
                                  id: 'Estatísticas do Estudante',
                                  domainFn: (StudentsStats stats, _) => stats.subject,
                                  measureFn: (StudentsStats stats, _) => stats.grade,
                                  colorFn: (StudentsStats stats, _) => charts.ColorUtil.fromDartColor(stats.color),
                                )
                              ];
                            }
                            
                            return
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 30.0),
                              width: SizeConfig.screenWidth,
                              height: !_selected1 && !_selected2 && !_selected3 ? SizeConfig.screenHeight !* 2 : SizeConfig.screenHeight !* 2.5,
                              color: backgroundColor,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(widget.student[0]["classroom"]["name"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 4.5 - .4, fontWeight: FontWeight.bold)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.grading, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentGrades(widget.student)));
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.calendar_today_outlined, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomSchedule(widget.student)));
                                            },
                                          ),
                                        ],
                                      )
                                    ]
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("PERÍODO: " + widget.student[0]["classroom"]["period"].toString().toUpperCase(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                            SizedBox(height: SizeConfig.heightMultiplier !* 1),
                                            Text("SALA: " + widget.student[0]["classroom"]["room"].toString().toUpperCase(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                            SizedBox(height: SizeConfig.heightMultiplier !* 1),
                                            Text("DIRECTOR DE TURMA: " + (teacher.length > 0 ? teacher[0]["teacher"]["teacher"]["teacherAccount"]["personalData"]["fullName"].toString().toUpperCase() : ""), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          ]
                                        ),
                                      ],
                                    ),
                                  ),
                                  //SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: ClipOval(
                                          child: widget.student[0]["student"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 30) : Image.network(baseImageUrl + widget.student[0]["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 45, height: SizeConfig.imageSizeMultiplier !* 45),
                                        ),
                                      ),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 2.5,),
                                      Text(widget.student[0]["student"]["personalData"]["fullName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7, fontWeight: FontWeight.bold)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                                      Text("N.º: " + widget.student[0]["number"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                                      Text("N.º de processo: " + widget.student[0]["studentId"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("TRIMESTRES: ", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.center,
                                        buttonHeight: SizeConfig.heightMultiplier !* .5,
                                        buttonMinWidth: SizeConfig.widthMultiplier !* .5,
                                        children: quarters.map((e) => 
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: e["id"] == quarterId ? Colors.white : letterColor,
                                              backgroundColor: e["id"] == quarterId ? borderAndButtonColor : Colors.white,
                                              textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold),
                                            ),
                                            child: Text(e["name"].toString()),
                                            onPressed: (){
                                              setState(() {
                                                quarterId = e["id"];
                                                getStudentScoresByQuarter(widget.student[0]["classroomStudentId"], quarterId, widget.student[0]["classroom"]["id"]);
                                              });
                                            }
                                          ),
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("NOTAS: ", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.center,
                                        buttonHeight: SizeConfig.heightMultiplier !* .5,
                                        buttonMinWidth: SizeConfig.widthMultiplier !* .5,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected1 ? Colors.white : letterColor,
                                              backgroundColor: _selected1 ? borderAndButtonColor : Colors.white,
                                              textStyle: !_selected1 ? TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                              : TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                            ),
                                            child: Text("MAC"),
                                            onPressed: (){
                                              setState(() {
                                                _selected1 = true;
                                                _selected2 = false;
                                                _selected3 = false;
                                                data.clear();
                                              });
                                            }
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected2 ? Colors.white : letterColor,
                                              backgroundColor: _selected2 ? borderAndButtonColor : Colors.white,
                                              textStyle: !_selected2 ? TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                              : TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                            ),
                                            child: Text("PP"),
                                            onPressed: (){
                                              setState(() {
                                                _selected1 = false;
                                                _selected2 = true;
                                                _selected3 = false;
                                                data.clear();
                                              });
                                            }
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected3 ? Colors.white : letterColor,
                                              backgroundColor: _selected3 ? borderAndButtonColor : Colors.white,
                                              textStyle: !_selected3 ? TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                              : TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                            ),
                                            child: Text("PT"),
                                            onPressed: (){
                                              setState(() {
                                                _selected1 = false;
                                                _selected2 = false;
                                                _selected3 = true;
                                                data.clear();
                                              });
                                            }
                                          ),
                                        ]
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 7),
                                  series.isNotEmpty ? Expanded(
                                    /*child: grafics.Chart(
                                      data: data,
                                      variables: {
                                        'subject': grafics.Variable(
                                          accessor: (Map map) => map['subject'] as String,
                                        ),
                                        'grade': grafics.Variable(
                                          accessor: (Map map) => map['grade'] as num,
                                        ),
                                      },
                                      elements: [grafics.IntervalElement()],
                                      axes: [
                                        grafics.Defaults.horizontalAxis,
                                        grafics.Defaults.verticalAxis,
                                      ],
                                    ),*/
                                    child: charts.BarChart(
                                      series,
                                      animate: true,
                                      vertical: true,
                                    ),
                                  ) : Container(),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            width: SizeConfig.widthMultiplier !* 23,
                                            height: SizeConfig.heightMultiplier !* 6,  
                                            color: Color.fromARGB(255, 233, 229, 229),
                                            alignment: Alignment.center,
                                            child: Text("Positivas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          ),
                                          Container(
                                            width: SizeConfig.widthMultiplier !* 10,
                                            height: SizeConfig.heightMultiplier !* 6,
                                            color: Colors.blue,
                                            alignment: Alignment.center,
                                            child: Text(quantPositivas.toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            width: SizeConfig.widthMultiplier !* 25,
                                            height: SizeConfig.heightMultiplier !* 6,  
                                            color: Color.fromARGB(255, 233, 229, 229),
                                            alignment: Alignment.center,
                                            child: Text("Negativas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          ),
                                          Container(
                                            width: SizeConfig.widthMultiplier !* 10,
                                            height: SizeConfig.heightMultiplier !* 6,
                                            color: Colors.red,
                                            alignment: Alignment.center,
                                            child: Text(quantNegativas.toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5.5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            width: SizeConfig.widthMultiplier !* 30,
                                            height: SizeConfig.heightMultiplier !* 6,  
                                            color: Color.fromARGB(255, 233, 229, 229),
                                            alignment: Alignment.center,
                                            child: Text("% Positivas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          ),
                                          Container(
                                            width: SizeConfig.widthMultiplier !* 10,
                                            height: SizeConfig.heightMultiplier !* 6,
                                            color: Colors.blue,
                                            alignment: Alignment.center,
                                            child: Text(percPositivas.floor().toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            width: SizeConfig.widthMultiplier !* 30,
                                            height: SizeConfig.heightMultiplier !* 6,  
                                            color: Color.fromARGB(255, 233, 229, 229),
                                            alignment: Alignment.center,
                                            child: Text("% Negativas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          ),
                                          Container(
                                            width: SizeConfig.widthMultiplier !* 10,
                                            height: SizeConfig.heightMultiplier !* 6,
                                            color: Colors.red,
                                            alignment: Alignment.center,
                                            child: Text(percNegativas.floor().toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                          )
                                        ],
                                      ),
                                    ]
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 10),
                                  Center(child: Text("PROFESSORES", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3), textAlign: TextAlign.center)),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  Expanded(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            DataTable(
                                              columnSpacing: SizeConfig.widthMultiplier !* 2.5,
                                              columns: [
                                                DataColumn(
                                                  label: Text(""),
                                                  numeric: false,
                                                ),
                                                DataColumn(
                                                  label: Text("Nome"),
                                                  numeric: false,
                                                ),
                                                DataColumn(
                                                  label: Text("Disciplina"),
                                                  numeric: false,
                                                ),
                                                DataColumn(
                                                  label: Text("D/T"),
                                                  numeric: false,
                                                ),
                                              ],
                                              rows: teachers.map((e) => 
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Center(
                                                        child: ClipOval(
                                                          child: e["teacher"]["teacher"]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + e["teacher"]["teacher"]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9.5, height: SizeConfig.imageSizeMultiplier !* 9),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(e["teacher"]["teacher"]["teacherAccount"]["personalData"]["fullName"].toString(), textAlign: TextAlign.left)
                                                      ),
                                                      showEditIcon: false,
                                                      placeholder: false,
                                                    ),
                                                    DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text(e["subject"]["isEliminated"] ? e["subject"]["subject"]["code"].toString() + " " + "(Contínua)" : e["subject"]["subject"]["code"].toString() + " " + "(Eliminatória)", textAlign: TextAlign.center)
                                                      ),
                                                      showEditIcon: false,
                                                      placeholder: false,
                                                    ),
                                                    DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: e['teacher']["teacher"]["id"] == teacher[0]["teacher"]["teacher"]["id"] ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)
                                                      ),
                                                      showEditIcon: false,
                                                      placeholder: false,
                                                    ),
                                                  ]
                                                )
                                              ).toList(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]  
                              ),
                            );
                          }
                      }
                    },
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xFF151717),
                elevation: 1,
                mouseCursor: SystemMouseCursors.grab,
                selectedFontSize: 15,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                selectedIconTheme: IconThemeData(color: Color(0xFF0D89A4), size: 30,),
                selectedItemColor: Color(0xFF0D89A4),
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                items: const <BottomNavigationBarItem> [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',                    
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap:(index){
                  setState(() {
                    _selectedIndex = index;
                  });
                  
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(index){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              height: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.account_circle, color: Colors.black, size: SizeConfig.imageSizeMultiplier !* 1.4 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
            ),
            Text(index["number"].toString()),
            Text(index["student"].toString()),
            Text(index["process"].toString()),
          ],
        ),
      ),
    );
  }
}

class StudentsStats{
  final String subject;
  final int grade;
  final Color color;

  StudentsStats(this.subject, this.grade, this.color);
}