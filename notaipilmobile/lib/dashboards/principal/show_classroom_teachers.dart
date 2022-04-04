import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/principal/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/show_classroom_statistics.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';

class ShowClassroomTeachers extends StatefulWidget {

  late String classroomId;
  late var principal = [];

  ShowClassroomTeachers(this.classroomId, this.principal);

  @override
  _ShowClassroomTeachersState createState() => _ShowClassroomTeachersState();
}

class _ShowClassroomTeachersState extends State<ShowClassroomTeachers> {

  int _selectedIndex = 0;
  int? informationLength;

  String? _classroomName;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var teachers = [];
  var filter = [];

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));

    getClassroomById(widget.classroomId).then((value) => 
      setState((){
        _classroomName = value[0]["name"].toString();
      })
    );

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
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 42, 55),
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
                            ),
                          ],
                          decoration: BoxDecoration(
                            color: drawerColor,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications, color: Colors.white,),
                          title: Text('Informações', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                          },
                          
                        ),
                        ListTile(
                          leading: Icon(Icons.group, color: Colors.white,),
                          title: Text('Pedidos de adesão', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: Colors.white,),
                          title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.white,),
                          title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.power_settings_new_sharp, color: Colors.white,),
                          title: Text('Sair', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.help_outline, color: Colors.white,),
                          title: Text('Ajuda', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => null,
                        )
                      ]
                    ),
                  )
                )
              ),
              body: SingleChildScrollView(
                child: FutureBuilder(
                  future: /*getTeachersByClassroom(widget.classroomId),*/getAllClassroomsTeachers(widget.classroomId),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          color: backgroundColor,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if(snapshot.hasError){
                          return Container();
                        } else {

                          teachers = (snapshot.data! as List);
                          
                          /*
                          if (filter.length == 0){  
                            if (teachers.length != 0){
                              filter.add({'teacher': teachers[0], 'subject': teachers[1]});                            
                            }                          
                          }*/

                          return Container( 
                            padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            color: backgroundColor,
                            child: Column(
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
                                          icon: Icon(Icons.calendar_today, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomSchedule(widget.classroomId, widget.principal)));
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.group_rounded, color: linKColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomTeachers(widget.classroomId, widget.principal)));
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.trending_up_rounded, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomStatistics(widget.classroomId, widget.principal)));
                                          },
                                        ),
                                      ],
                                    ),
                                    
                                  ]
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 10,),
                                Expanded(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15.0,
                                    mainAxisSpacing: 15.0,
                                    childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 2.5,
                                    children: teachers.map<Widget>((e) => 
                                      GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 20.0,
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(7.0),
                                            color: backgroundColor,
                                          ),
                                          child: Card(
                                            child: e["teacher"] != null ?
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(e["subject"]["subject"]["name"].toString(), style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.textMultiplier !* 4.5 - 10), textAlign: TextAlign.center),
                                                Center(
                                                  child: ClipOval(
                                                    child: e["teacher"]["teacher"]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 20) : Image.network(baseImageUrl + e["teacher"]["teacher"]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 20, height: SizeConfig.imageSizeMultiplier !* 20),
                                                  ),
                                                ),
                                                Text("Prof. " + e["teacher"]["teacher"]["teacherAccount"]["personalData"]["fullName"].toString(), style: TextStyle(fontFamily: fontFamily, color: teacherNameColor)),
                                                Text("Disciplina " + e["subject"]["subject"]["category"].toString(), style: TextStyle(fontFamily: fontFamily, color: letterColor),),
                                                e["teacher"]["responsible"] != false ? Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.info_rounded, color: iconColor,),
                                                    SizedBox(width: SizeConfig.widthMultiplier !* 2),
                                                    Text(e["teacher"]["teacher"]["teacherAccount"]["personalData"]["gender"] == "M" ? "Director de turma" : "Directora de turma"),
                                                  ],
                                                ) : Container(),
                                              ]
                                            ) : Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("Nenhum Professor", style: TextStyle(fontFamily: fontFamily, color: teacherNameColor),),
                                                Text("Disciplina " + e["subject"]["subject"]["category"].toString(), style: TextStyle(fontFamily: fontFamily, color: letterColor),),
                                              ],
                                            )
                                          ),
                                        )
                                      )                                    
                                    ).toList(),
                                  )
                                ),
                                /*
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("PROFESSORES", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 10,),
                                      Expanded(
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                              DataTable(
                                              columnSpacing: SizeConfig.widthMultiplier !* 7.5,
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
                                                  label: Text("Sexo"),
                                                  numeric: false,
                                                ),
                                                DataColumn(
                                                  label: Text("Disciplina"),
                                                  numeric: false,
                                                ),
                                              ],
                                              rows: filter.map((e) => 
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Center(
                                                        child: ClipOval(
                                                          child: e["teacher"]["teacher"]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + e["teacher"]["teacher"]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 15, height: SizeConfig.imageSizeMultiplier !* 15),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(e["teacher"]["teacher"]["teacherAccount"]["personalData"]["fullName"])
                                                      )
                                                    ),
                                                    DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text(e["teacher"]["teacher"]["teacherAccount"]["personalData"]["gender"])
                                                      )
                                                    ),
                                                    DataCell(
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text(e["subject"]["subjectName"])
                                                      )
                                                    ),
                                                    
                                                  ]
                                                )
                                              ).toList(),
                                            ),
                                          ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                */
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