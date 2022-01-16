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

import 'package:notaipilmobile/dashboards/principal/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/principal/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/show_classroom_statistics.dart';

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
                    padding: EdgeInsets.only(right: 20.0),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){},
                  )
                ],
              ),
              drawer: Navbar(),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomStatistics((widget.classroomId))));
                                },
                              ),
                            ],
                          )
                        ]
                      ),
                      Text("PERÍODO:", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                      Text("SALA:", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                      Text("DIRECTOR DE TURMA:", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
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
                      Text("MASCULINOS: _${_maleQuant}_ FEMENINOS: _${_femaleQuant}_"),
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