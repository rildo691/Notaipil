import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';
import 'dart:math';
import 'package:badges/badges.dart';
import 'package:graphic/graphic.dart' as grafics;
import 'package:charts_flutter/flutter.dart' as charts;

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';

class StudentStats extends StatefulWidget {

  late var principal = [];
  late var student;
  late var classroomId;

  StudentStats(this.principal, this.student, this.classroomId);

  @override
  _StudentStatsState createState() => _StudentStatsState();
}

class _StudentStatsState extends State<StudentStats> {

  var subjects = [];
  var quarters = [];
  var faults = [];
  var requests = [];
  var scores = [];

  var quarterId;

  int _selectedIndex = 0;
  int? informationLength;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<Map<dynamic, dynamic>> data = [];
  List<charts.Series<StudentsStats, String>> series = [];
  List<StudentsStats> studentData = [];
  List<charts.Series> seriesList = [];

  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });

    getSubjectByCourseAndGrade(widget.student["classroom"]["courseId"], widget.student["classroom"]["gradeId"]).then((value) => 
      setState((){
        subjects = value;
      })
    );

    getAdmissionRequests().then((value) {
      if (mounted){
        setState((){
          requests = value;
        });
      }
    });
  }

  Future<void> start() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              key: _key,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: appBarLetterColorAndDrawerColor),
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: borderAndButtonColor,
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
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
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                          },
                          
                        ),
                        ListTile(
                          leading: Icon(Icons.group, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Pedidos de adesão', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                          },
                          trailing: requests.isNotEmpty ?
                            Badge(
                              toAnimate: false,
                              shape: BadgeShape.circle,
                              badgeColor: Colors.red,
                              badgeContent: Text(requests.length.toString(), style: TextStyle(color: Colors.white),),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
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
                    ),
                  )
                )
              ),
              body: SingleChildScrollView(
                child: FutureBuilder(
                  future: Future.wait([getQuarter(), getStudentsFaultsByQuarter(widget.student["id"], quarterId), getStudentScoresByQuarter(widget.student["id"], quarterId, widget.classroomId)]),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          color: backgroundColor,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                            strokeWidth: 5.0
                          )
                        );
                      default:
                        if (snapshot.hasError){
                          return Container();
                        } else {

                          quarters = (snapshot.data! as List)[0];
                          faults = (snapshot.data! as List)[1];
                          scores = (snapshot.data! as List)[2];

                          if (_selected1) {
                            data.clear();
                            for (int i = 0; i < scores.length; i++){
                              Map<dynamic, dynamic> map = {
                                'subject': scores[i]["subject"]["subject"]["code"],
                                'grade': scores[i]["miniAgenda"][0]["mac"] ?? 0,
                              };
                              data.add(map);
                            }

                            studentData = data.map((e) => 
                              StudentsStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5))
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
                            for (int i = 0; i < scores.length; i++){
                              Map<dynamic, dynamic> map = {
                                'subject': scores[i]["subject"]["subject"]["code"],
                                'grade': scores[i]["miniAgenda"][0]["pp"] ?? 0,
                              };
                              data.add(map);
                            }

                            studentData = data.map((e) => 
                              StudentsStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5))
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
                            for (int i = 0; i < scores.length; i++){
                              Map<dynamic, dynamic> map = {
                                'subject': scores[i]["subject"]["subject"]["code"],
                                'grade': scores[i]["miniAgenda"][0]["pt"] ?? 0,
                              };
                              data.add(map);
                            }

                            studentData = data.map((e) => 
                              StudentsStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5))
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
                            padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                            width: SizeConfig.screenWidth,
                            height: !_selected1 && !_selected2 && !_selected3 ? SizeConfig.screenHeight !* 1.75 : SizeConfig.screenHeight !* 2.12,
                            color: backgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: ClipOval(
                                    child: widget.student["student"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 30) : Image.network(baseImageUrl + widget.student["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 45, height: SizeConfig.imageSizeMultiplier !* 45),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 2.5,),
                                Text(widget.student["student"]["personalData"]["fullName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                                Text("Estudante", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3, fontWeight: FontWeight.bold)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                Container(
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: backgroundColor,
                                  ),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Dados pessoais", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4, fontWeight: FontWeight.bold)),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                            Icon(Icons.cake_rounded, color: iconColor),
                                            SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                            Text("Nascido aos " + widget.student["student"]["personalData"]["birthdate"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                          ]
                                        ),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                            Icon(Icons.perm_contact_cal_rounded, color: iconColor),
                                            SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                            Text("B.I. nº: " + widget.student["student"]["personalData"]["bi"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                          ]
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                Container(
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: backgroundColor,
                                  ),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Dados académicos", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4, fontWeight: FontWeight.bold)),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                            Icon(Icons.cast_for_education, color: iconColor),
                                            SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                            Text("N' de Processo: " + widget.student["student"]["process"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                          ]
                                        ),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                            Icon(Icons.co_present_rounded, color: iconColor),
                                            SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                            Text("Turma: " + widget.student["classroom"]["name"].toString() + " / " + "Nº: " + widget.student["number"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                          ]
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                Container(
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: backgroundColor,
                                  ),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Contactos", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4, fontWeight: FontWeight.bold)),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                            Icon(Icons.contact_phone, color: iconColor),
                                            SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                            Text(widget.student["student"]["email"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                          ]
                                        ),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                            Icon(Icons.contact_mail, color: iconColor),
                                            SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                            Text(widget.student["student"]["telephone"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                          ]
                                        )
                                      ],
                                    ),
                                  ),
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
                                              getStudentsFaultsByQuarter(widget.student["id"], quarterId);
                                              getStudentScoresByQuarter(widget.student["id"], quarterId, widget.classroomId);
                                            });
                                          }
                                        ),
                                      ).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [ 
                                      DataTable(
                                        columns: [
                                          DataColumn(
                                            label: Text("Disciplina"),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Faltas"),
                                            numeric: false,
                                          ),
                                        ],
                                        rows: faults.map((e) => 
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(e['name'].toString(), textAlign: TextAlign.left)
                                                ),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(e["faults"].toString(), textAlign: TextAlign.right)
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
                                SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                data.isNotEmpty ? Expanded(
                                  child: grafics.Chart(
                                    data: data as List<Map<dynamic, dynamic>>,
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
                                    transforms: [

                                    ],
                                  ),
                                ) : Container(),
                              ],
                            ),
                          );
                        }
                    }
                  },
                )
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
                  switch(index){
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.principal)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(index, widget.principal)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordinationTeachers(index, widget.principal)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAgendaState(index, widget.principal)));
                      break;
                    default:
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class StudentsStats{
  final String subject;
  final int grade;
  final Color color;

  StudentsStats(this.subject, this.grade, this.color);
}