import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:badges/badges.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**User Interface */
import 'package:expansion_tile_card/expansion_tile_card.dart';

/**Complemets */
import 'package:notaipilmobile/dashboards/student/profile.dart';
import 'package:notaipilmobile/dashboards/student/studetInformations.dart';
import 'package:notaipilmobile/dashboards/student/classroom_student.dart';
import 'package:notaipilmobile/dashboards/student/entities.dart';
import 'package:notaipilmobile/dashboards/student/grades_history.dart';
import 'package:notaipilmobile/dashboards/student/main_page.dart';

class MainPage extends StatefulWidget {

  late var student = [];

  MainPage(this.student);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;
  int informationLength = 0;
  int quantPositivas = 0;
  int quantNegativas = 0;

  bool _selected1 = true;
  bool _selected2 = false;
  bool _selected3 = false;

  List<Map<dynamic, dynamic>> data = [];
  List<charts.Series<StudentStats, String>> series = [];
  List<StudentStats> studentData = [];
  List<charts.Series> seriesList = [];

  var subjects;
  var teachers;
  var studentLength;
  var year;
  var scores = [];
  var quarter = [];

  double quarterMedia = 0;
  double quarterSum = 0.0;
  int contSum = 0;

  @override
  void initState() {
    
    super.initState();

    getUnreadInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });

    getActiveQuarter().then((value) {
      if (mounted){
        setState(() {
          quarter = value;   
        });
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
                        accountName: new Text(widget.student[0]["student"]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        accountEmail: new Text(widget.student[0]["student"]["personalData"]["gender"] == "M" ? "Aluno" : "Aluna", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        currentAccountPicture: new ClipOval(
                          child: widget.student[0]["student"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.student[0]["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.student[0]["student"]["personalData"]["fullName"].toString().substring(0, 1)),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Studetinformations(widget.student)))
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.student)))
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
                child: FutureBuilder(
                    future: Future.wait([getAllStudentSubjectsLength(widget.student[0]["studentId"]), getAllStudentTeachersLength(widget.student[0]["studentId"]), getAllStudentStudentsLength(widget.student[0]["studentId"]), getStudentScoresByQuarter(widget.student[0]["classroomStudentId"], widget.student[0]["quarterId"], widget.student[0]["classroom"]["id"])]),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
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

                            subjects = (snapshot.data! as List)[0];
                            teachers = (snapshot.data! as List)[1];
                            studentLength = (snapshot.data! as List)[2];
                            scores = (snapshot.data! as List)[3];

                            if (widget.student[0]["classroom"]["name"].toString().contains("10")){
                              year = "1º";
                            } else if (widget.student[0]["classroom"]["name"].toString().contains("11")){
                              year = "2º";
                            } else if (widget.student[0]["classroom"]["name"].toString().contains("12")){
                              year = "3º";
                            } else if (widget.student[0]["classroom"]["name"].toString().contains("13")){
                              year = "4º";
                            }

                            for (int i = 0; i < scores.length; i++){
                              if (scores[i]["miniAgenda"][0]["mt"] != null){
                                quarterSum += int.parse(scores[i]["miniAgenda"][0]["mt"].toString());
                                contSum++;
                              }
                            }

                            quarterMedia = quarterSum / contSum;

                            if(_selected1) {
                              data.clear();
                              quantPositivas = 0;
                              quantNegativas = 0;
                              for (int i = 0; i < scores.length; i++){

                                if (scores[i]["miniAgenda"][0]["mac"] != null){
                                  if (scores[i]["miniAgenda"][0]["mac"] > 10){
                                    quantPositivas++;
                                  } else {
                                    quantNegativas++;
                                  }
                                }

                                Map<dynamic, dynamic> map = {
                                  'subject': scores[i]["subject"]["subject"]["code"],
                                  'grade': scores[i]["miniAgenda"][0]["mac"] ?? 0,
                                };
                                data.add(map);
                              }

                              studentData = data.map((e) => 
                                StudentStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5)),
                              ).toList();

                              series = [
                                charts.Series(
                                  data: studentData,
                                  id: 'Estatísticas do Estudante',
                                  domainFn: (StudentStats stats, _) => stats.subject,
                                  measureFn: (StudentStats stats, _) => stats.grade,
                                  colorFn: (StudentStats stats, _) => charts.ColorUtil.fromDartColor(stats.color),
                                )
                              ];

                            } else if (_selected2){
                              data.clear();
                              quantPositivas = 0;
                              quantNegativas = 0;
                              for (int i = 0; i < scores.length; i++){

                                if (scores[i]["miniAgenda"][0]["pp"] != null){
                                  if (scores[i]["miniAgenda"][0]["pp"] > 10){
                                    quantPositivas++;
                                  } else {
                                    quantNegativas++;
                                  }
                                }

                                Map<dynamic, dynamic> map = {
                                  'subject': scores[i]["subject"]["subject"]["code"],
                                  'grade': scores[i]["miniAgenda"][0]["pp"] ?? 0,
                                };
                                data.add(map);
                              }

                              studentData = data.map((e) => 
                                StudentStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5)),
                              ).toList();

                              series = [
                                charts.Series(
                                  data: studentData,
                                  id: 'Estatísticas do Estudante',
                                  domainFn: (StudentStats stats, _) => stats.subject,
                                  measureFn: (StudentStats stats, _) => stats.grade,
                                  colorFn: (StudentStats stats, _) => charts.ColorUtil.fromDartColor(stats.color),
                                )
                              ];
                            } else if (_selected3){
                              data.clear();
                              quantPositivas = 0;
                              quantNegativas = 0;
                              for (int i = 0; i < scores.length; i++){

                                if (scores[i]["miniAgenda"][0]["pt"] != null){
                                  if (scores[i]["miniAgenda"][0]["pt"] > 10){
                                    quantPositivas++;
                                  } else {
                                    quantNegativas++;
                                  }
                                }

                                Map<dynamic, dynamic> map = {
                                  'subject': scores[i]["subject"]["subject"]["code"],
                                  'grade': scores[i]["miniAgenda"][0]["pt"] ?? 0,
                                };
                                data.add(map);
                              }

                              studentData = data.map((e) => 
                                StudentStats(e["subject"], e["grade"], int.parse(e["grade"].toString()) > 10 ? Color.fromRGBO(53, 162, 235, .5) : Color.fromRGBO(255, 99, 132, .5)),
                              ).toList();

                              series = [
                                charts.Series(
                                  data: studentData,
                                  id: 'Estatísticas do Estudante',
                                  domainFn: (StudentStats stats, _) => stats.subject,
                                  measureFn: (StudentStats stats, _) => stats.grade,
                                  colorFn: (StudentStats stats, _) => charts.ColorUtil.fromDartColor(stats.color),
                                )
                              ];
                            }

                            return
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 30.0),
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight !* 1.5,
                              color: backgroundColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GridView.count(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 6,
                                    children: [
                                      _buildCard(studentLength > 0 ? "Alunos" : "Aluno", studentLength.toString(), Color.fromARGB(255, 0, 191, 252)),
                                      _buildCard(subjects > 0 ? "Disciplinas" : "Disciplina", subjects.toString(), Color.fromARGB(255, 241, 188, 109)),
                                      _buildCard(teachers > 0 ? "Professores" : "Professor", teachers.toString(), Color.fromARGB(255, 13, 137, 164)),
                                      _buildCard("Ano", year.toString(), Color.fromARGB(255, 225, 106, 128)),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("NOTAS: ", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.center,
                                        buttonHeight: SizeConfig.heightMultiplier !* .5,
                                        buttonMinWidth: SizeConfig.widthMultiplier !* .5,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected1 ? Colors.white : letterColor,
                                              backgroundColor: _selected1 ? borderAndButtonColor : Colors.white,
                                              textStyle: !_selected1 ? TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                              : TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                            ),
                                            child: Text("MAC"),
                                            onPressed: (){
                                              setState(() {
                                                _selected1 = true;
                                                _selected2 = false;
                                                _selected3 = false;
                                              });
                                            }
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected2 ? Colors.white : letterColor,
                                              backgroundColor: _selected2 ? borderAndButtonColor : Colors.white,
                                              textStyle: !_selected2 ? TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                              : TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                            ),
                                            child: Text("PP"),
                                            onPressed: (){
                                              setState(() {
                                                _selected1 = false;
                                                _selected2 = true;
                                                _selected3 = false;
                                              });
                                            }
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected3 ? Colors.white : letterColor,
                                              backgroundColor: _selected3 ? borderAndButtonColor : Colors.white,
                                              textStyle: !_selected3 ? TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold) 
                                              : TextStyle(color: Colors.white, fontFamily: fontFamily, fontWeight: FontWeight.bold) ,
                                            ),
                                            child: Text("PT"),
                                            onPressed: (){
                                              setState(() {
                                                _selected1 = false;
                                                _selected2 = false;
                                                _selected3 = true;
                                              });
                                            }
                                          ),
                                        ]
                                      ),
                                    ],
                                  ),
                                  series.isNotEmpty ? Expanded(
                                    child: charts.BarChart(
                                      series,
                                      animate: true,
                                      vertical: true,
                                    ),
                                  ) : Container(),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 6),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Postivas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                              SizedBox(height: SizeConfig.heightMultiplier !* 1),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: Color.fromRGBO(53, 162, 235, .5),
                                                ),
                                                width: SizeConfig.widthMultiplier !* 13,
                                                height: SizeConfig.heightMultiplier !* 6,
                                                alignment: Alignment.center,
                                                child: Text(quantPositivas.toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Negativas", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                              SizedBox(height: SizeConfig.heightMultiplier !* 1),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: Color.fromRGBO(255, 99, 132, .5),
                                                ),
                                                width: SizeConfig.widthMultiplier !* 13,
                                                height: SizeConfig.heightMultiplier !* 6,
                                                alignment: Alignment.center,                                              
                                                child: Text(quantNegativas.toString(), style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier !* 4,
                                      ),
                                      Text("Estado:", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier !* 2.5,
                                      ),
                                      OutlinedButton(
                                        child: Text("Em progresso", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 3.0, color: Color(0xFFF1BC6D),),
                                          primary: letterColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                          minimumSize: Size(SizeConfig.widthMultiplier !* 45, SizeConfig.heightMultiplier !* 7)
                                        ),
                                        onPressed: (){}, 
                                      ),
                                    ]
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Média Trimestral:", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier !* 2.5,
                                      ),
                                      OutlinedButton(
                                        child: Text(quarterMedia.toString() + " " + "valores", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                        style: OutlinedButton.styleFrom(
                                          side: quarterMedia > 10 ? BorderSide(width: 3.0, color: Color(0xFF00AD96),) : BorderSide(width: 3.0, color: Colors.red,),
                                          primary: letterColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                          minimumSize: Size(SizeConfig.widthMultiplier !* 45, SizeConfig.heightMultiplier !* 7)
                                        ),
                                        onPressed: (){}, 
                                      ),
                                    ]
                                  )
                                ]  
                              ),
                            );
                          }
                      }
                    },
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
                  switch(index){
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.student)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomStudent(widget.student)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GradesHistory(widget.student)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Entities(widget.student)));
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

  Widget _buildCard(String s, String t, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              height: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.4 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
            ),
            SizedBox(width: 7.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(t, style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4)),
                Text(s, style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StudentStats{
  final String subject;
  final int grade;
  final Color color;

  StudentStats(this.subject, this.grade, this.color);
}