import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:intl/intl.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/teacher/student_absence.dart';
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';

/**User Interface */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class SetClassroomAttendance extends StatefulWidget {

  late var teacher = [];
  late String classroomId;
  late var subject;

  SetClassroomAttendance(this.teacher, this.classroomId, this.subject);

  @override
  _SetClassroomAttendanceState createState() => _SetClassroomAttendanceState();
}

class _SetClassroomAttendanceState extends State<SetClassroomAttendance> {

  int _selectedIndex = 0;
  int? informationLength;

  String? _classroomName;

  TextEditingController _data = TextEditingController();
  TextEditingController _classDescription = TextEditingController();
  TextEditingController _classTime = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();

   getClassroomById(widget.classroomId).then((value) => 
      setState((){
        _classroomName = value[0]["name"].toString();
      })
    );

    getUnreadInformations(widget.teacher[1]["userId"], widget.teacher[1]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));
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
                child: FutureBuilder(
                  future: start(),
                  builder: (context, snapshot){
                    switch (snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
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
                        if (snapshot.hasError){
                          return Container(); 
                        } else {
                          return
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight !- 90,
                            color: backgroundColor,
                            child: Form(
                              key: _key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Marcação de Presença", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.calendar_today, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomSchedule(widget.teacher, widget.classroomId, widget.subject)));
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.group_rounded, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomTeachers(widget.teacher, widget.classroomId, widget.subject)));
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.edit_calendar, color:  linKColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SetClassroomAttendance(widget.teacher, widget.classroomId, widget.subject)));
                                            },
                                          ),
                                        ],
                                      )
                                    ]
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 8,
                                  ),
                                  Align( alignment: Alignment.centerLeft, child: Text(_classroomName != null ? _classroomName.toString() : "Nulo")),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 1.5,
                                  ),
                                  Align(alignment: Alignment.centerLeft, child: Text(widget.subject["name"].toString())),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 8,
                                  ),
                                  DateTimeField(
                                    decoration: InputDecoration(
                                      labelText: "Data da aula",
                                      suffixIcon: Icon(Icons.event_note, color: iconColor),
                                      labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    ),
                                    controller: _data,
                                    format: DateFormat("yyyy-MM-dd"),
                                    style:  TextStyle(color: letterColor),
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                        context: context,
                                        locale: const Locale("pt"),
                                        firstDate: DateTime(1900),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now(),
                                      ).then((date){
                                        setState((){
                                          _data.text = date.toString();
                                        });
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  buildTextFieldRegister("Descrição da aula", TextInputType.text, _classDescription),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  buildTextFieldRegister("Tempos dados", TextInputType.number, _classTime),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 6,
                                  ),
                                  ElevatedButton(
                                    child: Text("Confirmar"),
                                    style: ElevatedButton.styleFrom(
                                      primary:   borderAndButtonColor,
                                      onPrimary: Colors.white,
                                      textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),
                                      minimumSize: Size(0.0, 50.0),
                                    ),
                                    onPressed: (){
                                      if (_key.currentState!.validate()){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAbsence(widget.teacher, widget.classroomId, widget.subject)));
                                      }
                                    },
                                  )
                                ],
                              ),
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