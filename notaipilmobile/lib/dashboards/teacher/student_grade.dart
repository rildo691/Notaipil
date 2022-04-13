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

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Model */
import 'package:notaipilmobile/register/model/studentGradeModel.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/classroom_subject_stats.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';


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
  int informationLength = 0;

  double? media = 0.0;

  TextEditingController _firstTestController = TextEditingController();
  TextEditingController _secondTestController = TextEditingController();
  TextEditingController _macController = TextEditingController();

  var students = [];
  var quarter = [];
  var teacher = [];

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _macKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _ppKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _ptKey = GlobalKey<FormFieldState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Datum> grades = [];

  StudentGradeModel studentGradeModel = StudentGradeModel();
  Datum datum = Datum();

  @override
  void initState(){
    super.initState();

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
                          trailing: informationLength > 0 ?
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
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                  width: SizeConfig.screenWidth,
                  //height: SizeConfig.screenHeight !* 1.13999,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: Future.wait([getAllClassroomStudents(widget.classroom["id"]), getActiveQuarter(), getTeacherInClassroom(widget.teacher[0]["id"], widget.classroom["id"])]),
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

                            students = (snapshot.data! as List)[0];
                            quarter = (snapshot.data! as List)[1];
                            teacher = (snapshot.data! as List)[2];

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
                                      Text("Lançar notas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.stacked_line_chart_sharp, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomSubjectStats(widget.teacher, widget.classroom, widget.subject)));
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.text_snippet_outlined, color: linKColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
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
                                      Text(widget.classroom["name"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                      Text(" / ", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),
                                      Text(widget.subject["name"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.5),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 1.5,
                                  ),
                                  Align(alignment: Alignment.centerLeft, child: Text("II Trimestre", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),)),
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
                                      Text(students[i]["student"]["personalData"]["fullName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 5,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    decoration: InputDecoration(
                                      labelText: "MAC",
                                      labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                      filled: true,
                                      fillColor: fillColor,
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _macController,
                                    validator: (String? value){
<<<<<<< HEAD
=======
                                      if (value!.isEmpty){
                                        return "Preencha o campo MAC";
                                      } 
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                                      if (value.toString().length > 2 || int.parse(value.toString()) < 0 || int.parse(value.toString()) > 20){
                                        return "Certifique-se que a nota não tem mais de dois dígitos ou esteja no intervalo de 0 a 20";
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    decoration: InputDecoration(
                                      labelText: "PP",
                                      labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                      filled: true,
                                      fillColor: fillColor,
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _firstTestController,
                                    validator: (String? value){
<<<<<<< HEAD
=======
                                      if (value!.isEmpty){
                                        return "Preencha o campo PP";
                                      }
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                                      if (value.toString().length > 2 || int.parse(value.toString()) < 0 || int.parse(value.toString()) > 20){
                                        return "Certifique-se que a nota não tem mais de dois dígitos ou esteja no intervalo de 0 a 20";
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    decoration: InputDecoration(
                                      labelText: "PT",
                                      labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                      filled: true,
                                      fillColor: fillColor,
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _secondTestController,
                                    validator: (String? value){
<<<<<<< HEAD
=======
                                      if (value!.isEmpty){
                                        return "Preencha o campo PT";
                                      }
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                                      if (value.toString().length > 2 || int.parse(value.toString()) < 0 || int.parse(value.toString()) > 20){
                                        return "Certifique-se que a nota não tem mais de dois dígitos ou esteja no intervalo de 0 a 20";
                                      }
                                    },
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
                                          color: i <= students.length - 2 ? borderAndButtonColor : borderAndButtonColor,
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
                                          if (_key.currentState!.validate()){
                                            if (i <= students.length-2){
                                              setState((){
                                                _buildModal(i);
                                              });
                                            } else {
                                              _buildFinalModal(i);
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

<<<<<<< HEAD
                    if (!(_macController.text.isEmpty && _firstTestController.text.isEmpty && _secondTestController.text.isEmpty)){
                      datum = Datum (
                        mac: int.parse(_macController.text.toString()),
                        pp: int.parse(_firstTestController.text.toString()),
                        pt: int.parse(_secondTestController.text.toString()),
                        teacherInClassroomId: teacher[0]["id"],
                        classroomStudentId: students[i]["id"],
                      );
                    }
=======
                    datum = Datum (
                      mac: int.parse(_macController.text.toString()),
                      pp: int.parse(_firstTestController.text.toString()),
                      pt: int.parse(_secondTestController.text.toString()),
                      teacherInClassroomId: teacher[0]["id"],
                      classroomStudentId: students[i]["id"],
                    );
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

                    setState((){
                      grades.add(datum);

                      _macController.text = "";
                      _firstTestController.text = "";
                      _secondTestController.text = "";

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

  Future<dynamic>? _buildFinalModal(id) async{
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
                  onPressed: () async {
<<<<<<< HEAD
                    if (!(_macController.text.isEmpty && _firstTestController.text.isEmpty && _secondTestController.text.isEmpty)){
                      datum = Datum (
                        mac: int.parse(_macController.text.toString()),
                        pp: int.parse(_firstTestController.text.toString()),
                        pt: int.parse(_secondTestController.text.toString()),
                        teacherInClassroomId: teacher[0]["id"],
                        classroomStudentId: students[i]["id"],
                      );
                    }
=======
                    datum = Datum (
                      mac: int.parse(_macController.text.toString()),
                      pp: int.parse(_firstTestController.text.toString()),
                      pt: int.parse(_secondTestController.text.toString()),
                      teacherInClassroomId: teacher[0]["id"],
                      classroomStudentId: students[i]["id"],
                    );
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

                    grades.add(datum);

                    studentGradeModel.data = grades;

                    Navigator.pop(context);

                    var response = await helper.patch("mini_agendas", studentGradeModel.toJson());
                    buildModalMaterialPage(context, response["error"], response["message"], MaterialPageRoute(builder: (context) => Agendas(widget.teacher)));
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

