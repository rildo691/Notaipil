import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:badges/badges.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_classroom_stats.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/coordinator/edit_classroom.dart';
import 'package:notaipilmobile/dashboards/coordinator/student_stats.dart';
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';

class ShowClassroomPage extends StatefulWidget {
  late String classroomId;
  late var coordinator = [];

  ShowClassroomPage(this.classroomId, this.coordinator);

  @override
  _ShowClassroomPageState createState() => _ShowClassroomPageState();
}

class _ShowClassroomPageState extends State<ShowClassroomPage> {

  int _selectedIndex = 0;
  int? informationLength;

  String? _classroomName;
  String? _areaId;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var classroom = [];
  var students = [];
  var teacher = [];
  var _maleQuant;
  var _femaleQuant;
  var coursesLength;
  var area = [];

  @override
  void initState(){
    super.initState();

    getClassroomById(widget.classroomId).then((value) => 
      setState((){
        classroom = value;
        _classroomName = classroom[0]["name"].toString();
      })
    );

    getAllClassroomStudents(widget.classroomId).then((value) => 
      setState((){
        students = value;
      })
    );

    getAllClassroomsStudentsGender(widget.classroomId).then((value) => 
      setState((){
        _maleQuant = value[0];
        _femaleQuant = value [1];
      })
    );

    setState(() {
      _areaId = widget.coordinator[0]["courses"][0]["areaId"];
    });

    getAreaById(widget.coordinator[0]["courses"][0]["areaId"]).then((value) =>
      setState((){
        area = value;
      })
    );

    getCoursesByArea(widget.coordinator[0]["courses"][0]["areaId"]).then((value) => 
      setState((){
        coursesLength = value.length;
      })
    );

    getUnreadInformations(widget.coordinator[2]["userId"], widget.coordinator[2]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }

  Future<void> start() async{
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
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: appBarLetterColorAndDrawerColor),
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
                        accountName: new Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        accountEmail: new Text(widget.coordinator[0]["courses"].length == coursesLength ? widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador da Área de " + widget.coordinator[1]["name"] : "Coordenadora da Área de " + widget.coordinator[1]["name"] : widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        currentAccountPicture: new ClipOval(
                          child: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.coordinator[0]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: borderAndButtonColor,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Informações', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        trailing: informationLength !> 0 ?
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
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.coordinator)))
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
                  future: getClassroomResponsible(widget.classroomId),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting: 
                        return Container(
                          color: backgroundColor,
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if(snapshot.hasError){
                          return Container();
                        } else {

                          teacher = (snapshot.data! as List);

                          for (int i = 0; i < students.length; i++){
                            var name = students[i]["student"]["personalData"]["fullName"].toString();
                            var firstIndex = students[i]["student"]["personalData"]["fullName"].toString().indexOf(" ");
                            var lastIndex = students[i]["student"]["personalData"]["fullName"].toString().lastIndexOf(" ");
                              
                              
                            students[i]["student"]["personalData"]["fullName"] = name.substring(0, firstIndex) + name.substring(lastIndex, name.length);
                          }

                          return 
                          Container(
                          padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                          width: SizeConfig.screenWidth,
                          /*height: students.length < 7 ? students.length < 5 ? SizeConfig.screenHeight !- students.length * 50 : SizeConfig.screenHeight !* students.length / 6 : SizeConfig.screenHeight !* ((students.length * 10)/60),*/
                          height: SizeConfig.screenHeight,
                          color: backgroundColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(_classroomName.toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 4.5 - .4, fontWeight: FontWeight.bold)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.brush_outlined, color: (widget.coordinator[0]["courses"].length == coursesLength ||
                                        widget.coordinator[0]["courses"][0]["name"].toString().toUpperCase().contains(classroom[0]["course"]["name"].toString().toUpperCase())) ? iconColor : Colors.grey, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                        onPressed: (){
                                          if (widget.coordinator[0]["courses"].length == coursesLength){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditClassroom(widget.classroomId, widget.coordinator)));
                                          } else if (widget.coordinator[0]["courses"][0]["name"].toString().toUpperCase().contains(classroom[0]["course"]["name"].toString().toUpperCase())){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditClassroom(widget.classroomId, widget.coordinator)));
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomSchedule(widget.classroomId, widget.coordinator)));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.group_rounded, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomTeachers(widget.classroomId, widget.coordinator)));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.trending_up_rounded, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomStats(widget.classroomId, widget.coordinator)));
                                        },
                                      ),
                                    ],
                                  )
                                ]
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("PERÍODO: " + classroom[0]["period"].toString().toUpperCase(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 1),
                                        Text("SALA: " + classroom[0]["room"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 1),
                                        Text("DIRECTOR DE TURMA: " + (teacher.length > 0 ? teacher[0]["teacher"]["teacher"]["teacherAccount"]["personalData"]["fullName"].toString() : ""), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      ]
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                    Expanded(
                                      child: ListView(
                                        shrinkWrap: true,
                                        children:[ 
                                          DataTable(
                                            columnSpacing: SizeConfig.widthMultiplier !* 2,
                                            columns: [
                                              DataColumn(
                                                label: Text(""),
                                                numeric: false,
                                              ),
                                              DataColumn(
                                                label: Text("N.º"),
                                                numeric: true
                                              ),
                                              DataColumn(
                                                label: Text("Proc."),
                                                numeric: false,
                                              ),
                                              DataColumn(
                                                label: Text("Nome Completo"),
                                                numeric: false,
                                              ),
                                              DataColumn(
                                                label: Text("Sexo"),
                                                numeric: false,
                                              ),
                                            ],
                                            rows: students.map((e) => 
                                              DataRow(
                                                cells: [
                                                  DataCell(
                                                    Center(
                                                      child: ClipOval(
                                                        child: e["student"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + e["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9.5, height: SizeConfig.imageSizeMultiplier !* 9),
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e, widget.classroomId)));
                                                    }
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(e["number"].toString(), textAlign: TextAlign.center)
                                                    ),
                                                    showEditIcon: false,
                                                    placeholder: true,
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e, widget.classroomId)));
                                                    }
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(e["student"]['process'].toString(), textAlign: TextAlign.center)
                                                    ),
                                                    showEditIcon: false,
                                                    placeholder: true,
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e, widget.classroomId)));
                                                    }
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(e["student"]["personalData"]['fullName'].toString(), textAlign: TextAlign.left)
                                                    ),
                                                    showEditIcon: false,
                                                    placeholder: false,
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e, widget.classroomId)));
                                                    }
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(e["student"]["personalData"]['gender'].toString(), textAlign: TextAlign.center)
                                                    ),
                                                    showEditIcon: false,
                                                    placeholder: false,
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e, widget.classroomId)));
                                                    }
                                                  )
                                                ]
                                              )
                                            ).toList(),
                                          ),
                                        ]
                                      ),
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                    Text("MASCULINOS: _${_maleQuant}_ FEMENINOS: _${_femaleQuant}_", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        child: Text("Eliminar turma"),
                                        style: ElevatedButton.styleFrom(
                                          primary:  students.length > 0 ? Colors.grey : Color.fromRGBO(255, 20, 20, 50),
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),
                                          minimumSize: Size(0.0, 45.0),
                                        ),
                                        onPressed: (){
                                  
                                        },
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ]  
                          )
                        );
                        }
                    }
                  }
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.coordinator)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(widget.coordinator)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordination(widget.coordinator)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAgendaState(widget.coordinator)));
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