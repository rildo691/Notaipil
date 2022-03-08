import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/variables.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/teacher/set_classroom_attendance.dart';

class ShowClassroomTeachers extends StatefulWidget {

  late var teacher = [];
  late String classroomId;
  late var subject;

  ShowClassroomTeachers(this.teacher, this.classroomId, this.subject);

  @override
  _ShowClassroomTeachersState createState() => _ShowClassroomTeachersState();
}

class _ShowClassroomTeachersState extends State<ShowClassroomTeachers> {

  int _selectedIndex = 0;

  String? _classroomName;

  var teachers = [];
  var filter = [];

  @override
  void initState(){
    super.initState();

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
                        accountName: new Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                        accountEmail: new Text(widget.teacher[0]["teacherAccount"]["personalData"]["gender"] == "M" ? "Professor" : "Professora", style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"].toString().substring(0, 1)),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
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
                child: FutureBuilder(
                  future: getTeachersByClassroom(widget.classroomId),
                  builder: (context, snapshot){
                    switch (snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          color: Color.fromARGB(255, 34, 42, 55),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>( Color(0xFF0D89A4)),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError){
                          return Container();
                        } else {

                          teachers = (snapshot.data! as List);
                          
                          if (filter.length == 0){  
                            if (teachers.length != 0){
                              filter.add({'teacher': teachers[0], 'subject': teachers[1]});                            
                            }                          
                          }

                          return 
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            color: Color.fromARGB(255, 34, 42, 55),
                            child: Column(
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
                                          icon: Icon(Icons.calendar_today, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomSchedule(widget.teacher, widget.classroomId, widget.subject)));
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.group_rounded, color:  Color(0xFF0D89A4), size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomTeachers(widget.teacher, widget.classroomId, widget.subject)));
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit_calendar, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => SetClassroomAttendance(widget.teacher, widget.classroomId, widget.subject)));
                                          },
                                        ),
                                      ],
                                    )
                                    
                                  ]
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 10,),
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
                  
                },
              ),
            );
          },
        );
      },
    );
  }
}