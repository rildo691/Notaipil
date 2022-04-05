import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:intl/intl.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/variables.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';

class ShowCoordination extends StatefulWidget {
  late var coordinator = [];

  ShowCoordination(this.coordinator);

  @override
  _ShowCoordinationState createState() => _ShowCoordinationState();
}

class _ShowCoordinationState extends State<ShowCoordination> {

  var _courseValue;
  var _gradeValue;
  var _courseName;
  var _gradeName;
  var coursesLength;
  var area = [];
  var courses = [];
  var grades = [];
  var coordinators = [];
  var classrooms = [];
  var gender = [];
  var subjects = [];
  var filter = [];

  int _selectedIndex = 2;
  int? informationLength;

  String? _areaId;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();

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
                        trailing: informationLength != 0 ? ClipOval(
                          child: Container(
                            color: Colors.red,
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                informationLength.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ) : Container(),
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
                  future: Future.wait([getCoursesByArea(_areaId), getGrade(), getCoordinatiorsByArea(_areaId), getClassroomsByArea(_areaId), getStudentGenderByArea(_areaId), getSubjectByCourseAndGrade(_courseValue, _gradeValue)]),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                         width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          color: backgroundColor,
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
                          
                          courses = (snapshot.data! as List)[0];
                          grades = (snapshot.data! as List)[1];
                          coordinators = (snapshot.data! as List)[2];
                          classrooms = (snapshot.data! as List)[3];
                          gender = (snapshot.data! as List)[4];
                          subjects = (snapshot.data! as List)[5];

                          return 
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 50.0),
                                width: SizeConfig.screenWidth,
                                //height: SizeConfig.screenHeight,
                                color: backgroundColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildHeaderPartTwo("Coordenação de " + area[0]["name"].toString()),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 11),
                                    Column( 
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Coordenadores", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                            Text("", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                          ],
                                        ),
                                        SizedBox(height: SizeConfig.heightMultiplier !* 2.5),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: coordinators.length,
                                          itemBuilder: (context, index){
                                            return _buildCard(coordinators[index]);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: SizeConfig.widthMultiplier !* 30,
                                          child: SizedBox(
                                            child: DropdownButtonFormField(
                                              hint: Text("Curso"),
                                              style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                filled: true,
                                                fillColor: fillColor,
                                                hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                              ),
                                              dropdownColor: fillColor,
                                              items: courses.map((e) => 
                                                DropdownMenuItem<String>(
                                                  value: e["id"],
                                                  child: Text(e["code"].toString()),
                                                )
                                              ).toList(),
                                              value: _courseValue,
                                              onChanged: (newValue){
                                                setState(() {
                                                  _courseValue = newValue;
                                                  for (int i = 0; i < courses.length; i++){
                                                    if (courses[i]["id"] == _courseValue){
                                                      setState((){
                                                        _courseName = courses[i]["code"];
                                                      });
                                                    }
                                                  }
                                                });
                                              }
                                            )
                                          )
                                        ),
                                        Container(
                                          width: SizeConfig.widthMultiplier !* 30,
                                          child: SizedBox(
                                            child: DropdownButtonFormField(
                                              hint: Text("Classe"),
                                              style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                filled: true,
                                                fillColor: fillColor,
                                                hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                              ),
                                              dropdownColor: fillColor,
                                              items:grades.map((e) => 
                                                DropdownMenuItem<String>(
                                                  value: e["id"],
                                                  child: Text(e["name"].toString() + "ª"),
                                                )
                                              ).toList(),
                                              value: _gradeValue,
                                              onChanged: (newValue){
                                                filter.clear();
                                                setState((){
                                                  _gradeValue = newValue;
                                                });
                                                for (int i = 0; i < classrooms.length; i++){
                                                  if (classrooms[i]["courseId"] == _courseValue && classrooms[i]["gradeId"] == newValue){
                                                    setState((){
                                                      filter.add({"name": classrooms[i]["name"], "m": gender[i]["m"], "f": gender[i]["f"]});
                                                    });
                                                  }
                                                }
                                                for (int i = 0; i < grades.length; i++){
                                                  if (grades[i]["id"] == newValue){
                                                    setState((){
                                                      _gradeName = grades[i]["name"] + "ª";
                                                    });
                                                  }
                                                }
                                              }
                                            )
                                          )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7),
                                    Text(_gradeValue == null ? "" : "Estatística da $_gradeName classe - $_courseName", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                    DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text("TURMAS"),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text("M"),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text("F"),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text("MF"),
                                          numeric: false,
                                        )
                                      ],
                                      rows: filter.map((e) => 
                                        DataRow(
                                          cells: [
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(e["name"]),
                                              )
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(e["m"].toString()),
                                              )
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(e["f"].toString()),
                                              )
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text((int.parse(e["m"].toString()) + int.parse(e["f"].toString())).toString()),
                                              )
                                            ),
                                          ]
                                        )
                                      ).toList(),
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7),
                                    Text(_courseName == null ? "" : "Estatística do Curso $_courseName - $_gradeName classe", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                    DataTable(
                                      columnSpacing: SizeConfig.widthMultiplier !* 37,
                                      columns: [
                                        DataColumn(
                                          label: Text(""),
                                          numeric: false
                                        ),
                                        DataColumn(
                                          label: Text("Total"),
                                          numeric: false
                                        )
                                      ],
                                      rows: [
                                        DataRow(
                                          cells: [
                                            DataCell(
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("DISCIPLINAS"),
                                              )
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(subjects.length.toString()),
                                              )
                                            ),
                                          ]
                                        ),
                                        DataRow(
                                          cells: [
                                            DataCell(
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("TURMAS"),
                                              )
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(filter.length.toString()),
                                              )
                                            ),
                                          ]
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
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
          children: [
            ClipOval(
              child: index["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 15) : Image.network(baseImageUrl + index["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 15, height: SizeConfig.imageSizeMultiplier !* 15),
            ),
            Text(index["teacherAccount"]["personalData"]["fullName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
            Text(index["teacherAccount"]["personalData"]["gender"] == "M" ? index["courses"].length == courses.length ? "Coordenador da Área" : "Coordenador do curso de " + index["courses"][0]["code"] : index["courses"].length == courses.length ? "Coordenadora da Área" : "Coordenadora do curso de " + index["courses"][0]["code"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3))
          ],
        ),
      ),
    );
  }
}