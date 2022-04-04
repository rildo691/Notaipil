import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/show_classroom_page.dart';
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';

class Classrooms extends StatefulWidget {
  
  late var teacher = [];

  Classrooms(this.teacher);

  @override
  _ClassroomsState createState() => _ClassroomsState();
}

class _ClassroomsState extends State<Classrooms> {

  int _selectedIndex = 1;
  int j = 0;
  int? informationLength;

  var _areaValue;
  var areas = [];
  var data = [];
  var courses = [];
  var classrooms = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.teacher[1]["userId"], widget.teacher[1]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));
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
                    icon: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 9) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9, height: SizeConfig.imageSizeMultiplier !* 9),
                    onPressed: (){
                      _scaffoldKey.currentState!.openDrawer();
                    },
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
                        currentAccountPicture: new ClipOval(
                          child: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherinformtions(widget.teacher)))
                        },
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
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.teacher)))
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
                      )
                    ]
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: backgroundColor,
                  child:FutureBuilder(
                    future: Future.wait([getAreas(), getTeacherClassroomsOrganizedByAreaAndCourse(widget.teacher[0]["id"], _areaValue), getCoursesName(_areaValue)]),
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

                            areas = (snapshot.data! as List)[0];
                            data = (snapshot.data! as List)[1];
                            courses = (snapshot.data! as List)[2];

                            return 
                             Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildHeaderPartTwo("Turmas"),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                DropdownButtonFormField(
                                  hint: Text("Área de Formação"),
                                  style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: fillColor,
                                    hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                  ),
                                  dropdownColor: fillColor,
                                  items: areas.map((e) => 
                                    DropdownMenuItem(
                                      child: Text(e["name"].toString()),
                                      value: e["id"],
                                    )
                                  ).toList(),
                                  value: _areaValue,
                                  onChanged: (newValue){
                                    setState((){
                                      _areaValue = newValue;
                                    });
                                    getTeacherClassroomsOrganizedByAreaAndCourse(widget.teacher[0]["id"], _areaValue);
                                  },
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 12,),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index){
                                      if (index < courses.length){
                                        classrooms.clear();
                                        for (var d in data){
                                          for (int i = 0; i < courses.length; i++){
                                            if (d["course"] == courses[i]["name"] && !classrooms.contains(d["classroom"]["name"])){
                                              classrooms.add(d);
                                            }
                                          }
                                        }

                                        if (classrooms.isNotEmpty){
                                          return Column(
                                            children: [
                                              Text(data[index]["course"].toString()),
                                              SizedBox(height: SizeConfig.heightMultiplier !* 3,),
                                              GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 4.7,
                                                children: classrooms.map((e) => 
                                                  GestureDetector(
                                                    child: Card(
                                                      color: borderAndButtonColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(e["classroom"]["name"].toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                                              Text(e["subjectCourseGrade"]["subject"]["name"].toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3), textAlign: TextAlign.center)
                                                            ],
                                                          ),
                                                        )
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomPage(widget.teacher, e["classroom"]["id"], e["subjectCourseGrade"]["subject"])));
                                                    },
                                                  )
                                                ).toList(),
                                              ),
                                            ]
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }
                                      else {
                                        return Container();
                                      }
                                    },
                                  )
                                )
                              ]  
                            );
                          }
                      }
                    }
                  ),
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
                selectedItemColor: linKColor,
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