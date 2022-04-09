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
import 'package:badges/badges.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/teacher/set_classroom_attendance.dart';
import 'package:notaipilmobile/dashboards/teacher/show_classroom_page.dart';
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';

class StudentAbsence extends StatefulWidget {

  late var teacher = [];
  late String classroomId;
  late var subject;

  StudentAbsence(this.teacher, this.classroomId, this.subject);

  @override
  _StudentAbsenceState createState() => _StudentAbsenceState();
}

class _StudentAbsenceState extends State<StudentAbsence> {

  int _selectedIndex = 0;
  int i = 0;
  int? informationLength;

  String? _classroomName;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _dropdownKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _textfieldKey = GlobalKey<FormFieldState>();

  TextEditingController _faultNumber = TextEditingController();

  ApiService helper = ApiService();

  var _value;
  var students = [];
  var faults = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();

    getClassroomById(widget.classroomId).then((value) => 
      setState((){
        _classroomName = value[0]["name"].toString();
      })
    );

    getUnreadInformations(widget.teacher[1]["userId"], widget.teacher[1]["typeAccount"]["id"]).then((value) {
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
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.teacher[0]["teacherAccount"]["personalData"]["gender"] == "M" ? "Professor" : "Professora", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"].toString().substring(0, 1)),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherinformtions(widget.teacher)))
                          },
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
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.teacher)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 50,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: getAllClassroomStudents(widget.classroomId),
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
                              strokeWidth: 5.0,
                            ),
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            students = (snapshot.data! as List);
                            return 
                            Form(
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
                                            icon: Icon(Icons.edit_calendar, color: linKColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SetClassroomAttendance(widget.teacher, widget.classroomId, widget.subject)));
                                            },
                                          ),
                                        ],
                                      )
                                    ]
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 7,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        child: Text("Nº " + students[i]["number"].toString()),
                                        radius: 50,
                                      ),  
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier !* 2,
                                      ),
                                      Text(students[i]["student"]["personalData"]["fullName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 5,
                                  ),
                                  DropdownButtonFormField(
                                    hint: Text("Tipo de falta"),
                                    key: _dropdownKey,
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: fillColor,
                                      hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    ),
                                    dropdownColor: fillColor,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Normal"),
                                        value: "Normal"
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Disciplinar"),
                                        value: "Disciplinar"
                                      ),
                                    ],
                                    value: _value,
                                    onChanged: (newValue){
                                      setState((){
                                        _value = newValue;
                                      });
                                    },
                                    validator: (value) => value == null ? 'Preencha o campo Período' : null,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 5,
                                  ),/*
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        child: Text("0"),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                          primary:  Color(0xFF0D89A4),
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 20.0,
                                          ),
                                          minimumSize: Size(60.0, 50.0),
                                        ),
                                        onPressed: (){

                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text("1"),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                          primary:  Color(0xFF0D89A4),
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 20.0,
                                          ),
                                          minimumSize: Size(60.0, 50.0),
                                        ),
                                        onPressed: (){

                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text("2"),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                          primary:  Color(0xFF0D89A4),
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 20.0,
                                          ),
                                          minimumSize: Size(60.0, 50.0),
                                        ),
                                        onPressed: (){
                                      
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text("3"),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                          primary:  Color(0xFF0D89A4),
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 20.0,
                                          ),
                                          minimumSize: Size(60.0, 50.0),
                                        ),
                                        onPressed: (){
                                      
                                        },
                                      )
                                    ],
                                  ),*/
                                  TextFormField(
                                    key: _textfieldKey,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    decoration: InputDecoration(
                                      labelText: "N.º de faltas",
                                      labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                      filled: true,
                                      fillColor: fillColor,
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _faultNumber,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 13,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: i == 0 ? Colors.grey : borderAndButtonColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 4.7,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          if (i > 0){
                                            setState(() {
                                              i--;
                                            });
                                          }
                                        },
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: i <= students.length - 2 ? borderAndButtonColor: borderAndButtonColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text( i <= students.length - 2 ? "Próximo" : "Confirmar", style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 4.7,),
                                            ],
                                          ),
                                        ),
                                        onTap: () async{
                                          if (i <= students.length - 2){
                                            _buildModal(i);
                                          } else {
                                            Map<String, dynamic> map = {
                                              "number": students[i]["number"],
                                              "fault": _faultNumber.text,
                                              "description": _value.toString(),
                                              "teacherInClassroomId": widget.teacher[0]["id"],
                                              "classroomStudentId": students[i]["id"]
                                            };

                                            setState((){
                                              faults.add(map);
                                            });

                                            var response = await helper.post("presences", faults);
                                            buildModalMaterialPage(context, response["error"], response["message"], MaterialPageRoute(builder: (context) => ShowClassroomPage(widget.teacher, widget.classroomId, widget.subject)));                                         
                                          }
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                      }
                    },
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

  Future<Widget>? _buildModal(id){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text("Clique OK para confirmar", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.5), textAlign: TextAlign.center,),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: borderAndButtonColor,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    Map<String, dynamic> map = {
                      "number": students[id]["number"],
                      "fault": _faultNumber.text,
                      "description": _value.toString(),
                      "teacherInClassroomId": widget.teacher[0]["id"],
	                    "classroomStudentId": students[id]["id"]
                    };

                    setState((){
                      if (_faultNumber.text.isNotEmpty){
                        faults.add(map);
                      }

                      _faultNumber.text = "";
                      var value;

                      _textfieldKey.currentState!.reset();
                      _dropdownKey.currentState!.reset();

                      if (i <= students.length-2){
                        i++;
                      }
                      Navigator.pop(context);
                    });
                  },
                )
              ]
            ),
          )
        ); 
      }
    );
  }
}