import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:badges/badges.dart';
import 'package:graphic/graphic.dart' as grafics;

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';

class StudentsStats extends StatefulWidget {

  late var teacher = [];
  late var student;
  late var subject;
  late var classroomId;

  StudentsStats(this.teacher, this.student, this.classroomId);

  @override
  _StudentsStatsState createState() => _StudentsStatsState();
}

class _StudentsStatsState extends State<StudentsStats> {

  var subjects = [];
  var quarters = [];
  var faults = [];
  var scores = [];
  
  var quarterId;

  int _selectedIndex = 0;
  int informationLength = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<dynamic, dynamic>> data = [];

  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.teacher[1]["userId"], widget.teacher[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }

  Future<void> start() async {
    await Future.delayed(const Duration(seconds: 3));
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
                iconTheme: const IconThemeData(color: appBarLetterColorAndDrawerColor),
              ),
              drawer: Drawer(
                child: Container(
                  decoration: const BoxDecoration(
                    color: borderAndButtonColor,
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: Text(widget.teacher[0]["teacherAccount"]["personalData"]["gender"] == "M" ? "Professor" : "Professora", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: ClipOval(
                            child: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                          ),
                          otherAccountsPictures: [
                            CircleAvatar(
                              child: Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"].toString().substring(0, 1)),
                            ),
                          ],
                          decoration: const BoxDecoration(
                            color: borderAndButtonColor,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Informações', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherinformtions(widget.teacher)))
                          },
                          trailing: informationLength > 0 ?
                            Badge(
                              toAnimate: false,
                              shape: BadgeShape.circle,
                              badgeColor: Colors.red,
                              badgeContent: Text(informationLength.toString(), style: const TextStyle(color: Colors.white),),
                            ) :
                            Container(
                              width: 20,
                              height: 20,
                            ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.teacher)))
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.power_settings_new_sharp, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Sair', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: const Icon(Icons.help_outline, color: appBarLetterColorAndDrawerColor,),
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
                          child: const CircularProgressIndicator(
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
                          } else if (_selected2){
                            data.clear();
                            for (int i = 0; i < scores.length; i++){
                              Map<dynamic, dynamic> map = {
                                'subject': scores[i]["subject"]["subject"]["code"],
                                'grade': scores[i]["miniAgenda"][0]["pp"] ?? 0,
                              };
                              data.add(map);
                            }
                          } else if (_selected3){
                            data.clear();
                            for (int i = 0; i < scores.length; i++){
                              Map<dynamic, dynamic> map = {
                                'subject': scores[i]["subject"]["subject"]["code"],
                                'grade': scores[i]["miniAgenda"][0]["pt"] ?? 0,
                              };
                              data.add(map);
                            }
                          }

                          return 
                          Container(
                            padding: const EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
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
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 6.0,
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
                                            const Icon(Icons.cake_rounded, color: iconColor),
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
                                            const Icon(Icons.perm_contact_cal_rounded, color: iconColor),
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
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 6.0,
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
                                            const Icon(Icons.cast_for_education, color: iconColor),
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
                                            const Icon(Icons.co_present_rounded, color: iconColor),
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
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 6.0,
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
                                            const Icon(Icons.contact_phone, color: iconColor),
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
                                            const Icon(Icons.contact_mail, color: iconColor),
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
                                            textStyle: const TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold),
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
                                        columns: const [
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
                                                  child: Text(e["faults"].toString(), textAlign: TextAlign.center)
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
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
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
                                            textStyle: !_selected1 ? const TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                            : const TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                          ),
                                          child: const Text("MAC"),
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
                                            textStyle: !_selected2 ? const TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                            : const TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                          ),
                                          child: const Text("PP"),
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
                                            textStyle: !_selected3 ? const TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                            : const TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                          ),
                                          child: const Text("PT"),
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
                                  ),
                                ) : Container(),
                              ],
                            ),
                          );
                        }
                    }
                  },
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xFF151717),
                elevation: 1,
                mouseCursor: SystemMouseCursors.grab,
                selectedFontSize: 15,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                selectedIconTheme: const IconThemeData(color: const Color(0xFF0D89A4), size: 30,),
                selectedItemColor: linKColor,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: const TextStyle(color: Colors.grey),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.teacher)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Classrooms(widget.teacher)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule(widget.teacher)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Agendas(widget.teacher)));
                      break;
                    case 4:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Entities(widget.teacher)));
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