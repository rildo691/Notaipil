import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformtions.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:intl/intl.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/show_classroom_schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/show_classroom_teachers.dart';
import 'package:notaipilmobile/dashboards/teacher/classroom_subject_stats.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';

class StudentGrade extends StatefulWidget {

  late var teacher = [];
  late var classroom;
  late var subject;

  StudentGrade(this.teacher, this.classroom, this.subject);

  @override
  _StudentGradeState createState() => _StudentGradeState();
}

class _StudentGradeState extends State<StudentGrade> {

  int _selectedIndex = 0;
  int i = 0;

  double? media = 0.0;

  TextEditingController _firstTestController = TextEditingController();
  TextEditingController _secondTestController = TextEditingController();
  TextEditingController _macController = TextEditingController();

  var students = [];

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherinformtions(widget.teacher)))
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !* 1.1,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: getAllClassroomStudents(widget.classroom["id"]),
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
                                      Text("Lançar notas", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.stacked_line_chart_sharp, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomSubjectStats(widget.teacher, widget.classroom, widget.subject)));
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.text_snippet_outlined, color: Color(0xFF0D89A4), size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentGrade(widget.teacher, widget.classroom, widget.subject)));
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(widget.classroom["name"].toString()),
                                      Text("-----"),
                                      Text(widget.subject["name"].toString()),
                                    ],
                                  ),
                                  Align(alignment: Alignment.centerLeft, child: Text("II Trimestre")),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5,),
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
                                      Text(students[i]["student"]["personalData"]["fullName"].toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 5,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: "MAC",
                                      labelStyle: TextStyle(color: Colors.white),
                                      filled: true,
                                      fillColor: Color(0xFF202733),
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _macController,
                                    validator: (String? value){
                                      if (value!.isEmpty){
                                        return "Preencha o campo MAC";
                                      }
                                    },
                                    onChanged: (String? value){
                                      if (_macController.text.length <= 2){
                                        
                                      }
                                    }
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: "PP",
                                      labelStyle: TextStyle(color: Colors.white),
                                      filled: true,
                                      fillColor: Color(0xFF202733),
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _firstTestController,
                                    validator: (String? value){
                                      if (value!.isEmpty){
                                        return "Preencha o campo PP";
                                      }
                                    },
                                    onChanged: (String? value){
                                      if (_firstTestController.text.length <= 2){
                                        
                                      }
                                    }
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: "PT",
                                      labelStyle: TextStyle(color: Colors.white),
                                      filled: true,
                                      fillColor: Color(0xFF202733),
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _secondTestController,
                                    validator: (String? value){
                                      if (value!.isEmpty){
                                        return "Preencha o campo PT";
                                      }
                                    },
                                    onChanged: (String? value){
                                      if (_secondTestController.text.length <= 2){
                                        
                                      }
                                    }
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 7,
                                  ),
                                  Text("Média: " + media.toString()),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 7,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: i == 0 ? Colors.grey : Color.fromRGBO(0, 209, 255, 0.49),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
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
                                          color: i <= students.length - 2 ? Color.fromRGBO(0, 209, 255, 0.49) : Colors.grey,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Próximo", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          if (_key.currentState!.validate()){
                                            if (_macController.text.length <= 2 && _firstTestController.text.length <= 2 && _secondTestController.text.length <= 2){
                                              if ((double.parse(_macController.text) >= 0 && double.parse(_macController.text) <= 20) &&
                                                (double.parse(_firstTestController.text) >= 0 && double.parse(_firstTestController.text) <= 20) &&
                                                (double.parse(_secondTestController.text) >= 0 && double.parse(_secondTestController.text) <= 20)){
                                                  if (i <= students.length-2){
                                                    setState((){
                                                      i++;
                                                      _macController.text = "";
                                                      _firstTestController.text = "";
                                                      _secondTestController.text = "";
                                                    });
                                                  }
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg: "Notas devem variar de 0 a 20.",
                                                  toastLength: Toast.LENGTH_LONG,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  gravity: ToastGravity.BOTTOM,
                                                ).toString();
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "Notas devem conter entre 1 a 2 caracteres.",
                                                toastLength: Toast.LENGTH_LONG,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                gravity: ToastGravity.BOTTOM,
                                              ).toString();
                                            }
                                          } 
                                        }
                                      )
                                    ],
                                  )
                                ],
                              )
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

