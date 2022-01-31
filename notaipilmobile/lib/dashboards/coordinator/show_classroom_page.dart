import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';

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
import 'package:notaipilmobile/dashboards/coordinator/students_list.dart';

class ShowClassroomPage extends StatefulWidget {

  late String classroomId;
  ShowClassroomPage(this.classroomId);

  @override
  _ShowClassroomPageState createState() => _ShowClassroomPageState();
}

class _ShowClassroomPageState extends State<ShowClassroomPage> {

  int _selectedIndex = 0;
  String? _classroomName;

  var classroom = [];
  var students = [];
  var _maleQuant;
  var _femaleQuant;

  @override
  void intiState(){
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
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){},
                  )
                ],
              ),
              drawer: new Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 42, 55),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: new Text("Rildo Franco", style: TextStyle(color: Colors.white),),
                        accountEmail: new Text("Director", style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text("R"),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 34, 42, 55),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white,),
                        title: Text('Informações', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('Estudantes', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsList()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
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
                        trailing: ClipOval(
                          child: Container(
                            color: Colors.red,
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                '8',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_classroomName != null ? _classroomName.toString() : "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 4.1 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 5.5, fontFamily: 'Roboto',)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.brush_outlined, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditClassroom(widget.classroomId)));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomSchedule(widget.classroomId)));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.group_rounded, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomTeachers(widget.classroomId)));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.trending_up_rounded, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomStats((widget.classroomId))));
                                },
                              ),
                            ],
                          )
                        ]
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("PERÍODO:", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                Text("SALA:", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                Text("DIRECTOR DE TURMA:", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                              ]
                            ),
                            DataTable(
                              dataRowColor: MaterialStateColor.resolveWith((states) => 
                                states.contains(MaterialState.selected) ? Color.fromARGB(255, 34, 42, 55) : Color.fromARGB(255, 34, 42, 55)
                              ),
                              dataTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.2 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                              showBottomBorder: true,
                              dividerThickness: 5,
                              headingTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                              headingRowColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) 
                                ? Color(0xFF00D1FF) : Color(0xFF00D1FF)
                              ),
                              columnSpacing: SizeConfig.widthMultiplier !* 3,
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
                                      Center(child: Icon(Icons.account_circle, color: Colors.white,),)
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text("1", textAlign: TextAlign.center)
                                      ),
                                      showEditIcon: false,
                                      placeholder: true,
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(e['process'].toString(), textAlign: TextAlign.center)
                                      ),
                                      showEditIcon: false,
                                      placeholder: true,
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(e['fullName'].toString(), textAlign: TextAlign.left)
                                      ),
                                      showEditIcon: false,
                                      placeholder: false,
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats()));
                                      }
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(e['gender'].toString(), textAlign: TextAlign.center)
                                      ),
                                      showEditIcon: false,
                                      placeholder: false,
                                    )
                                  ]
                                )
                              ).toList(),
                            ),
                            Text("MASCULINOS: _${_maleQuant}_ FEMENINOS: _${_femaleQuant}_", style: TextStyle(color: Colors.white)),
                            ElevatedButton(
                              child: Text("Eliminar turma"),
                              style: ElevatedButton.styleFrom(
                                primary:  Color(0xFF0D89A4),
                                onPrimary: Colors.white,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 20.0,
                                ),
                                minimumSize: Size(0.0, 50.0),
                              ),
                              onPressed: (){
                        
                              },
                            )
                          ]
                        ),
                      ),
                    ]  
                  )
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
}