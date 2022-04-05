import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/classroom_subject_stats.dart';
import 'package:notaipilmobile/dashboards/teacher/student_grade.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';


class AgendaPage extends StatefulWidget {
  late var teacher = [];
  late var classroom;
  late var subject;

  AgendaPage(this.teacher, this.classroom, this.subject);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {

  int _selectedIndex = 0;
  int? informationLength;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  child: ListView(
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
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
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
                          Text("Minipautas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
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
                                icon: Icon(Icons.text_snippet_outlined, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentGrade(widget.teacher, widget.classroom, widget.subject)));
                                },
                              ),
                            ],
                          )

                        ]
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 10,),
                      Align(alignment: Alignment.centerLeft, child: Text(widget.classroom["name"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),)),
                      SizedBox(height: SizeConfig.heightMultiplier !* 1,),
                      Align(alignment: Alignment.centerLeft, child: Text(widget.subject["name"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),),
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