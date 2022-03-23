import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';

class StudentsStats extends StatefulWidget {

  late var teacher = [];
  late var student;
  late var subject;

  StudentsStats(this.teacher, this.student);

  @override
  _StudentsStatsState createState() => _StudentsStatsState();
}

class _StudentsStatsState extends State<StudentsStats> {

  var _selected1 = true;
  var _selected2 = false;
  var _selected3 = false;

  int _selectedIndex = 0;

  Future<void> start() async {
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
                        currentAccountPicture: new ClipOval(
                          child: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 15, height: SizeConfig.imageSizeMultiplier !* 23),
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
                  future: start(),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          color: Color.fromARGB(255, 34, 42, 55),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D89A4)),
                            strokeWidth: 5.0
                          )
                        );
                      default:
                        if (snapshot.hasError){
                          return Container();
                        } else {
                          return 
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight !* 1.2,
                            color: Color.fromARGB(255, 34, 42, 55),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Aluno", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                Center(
                                  child: 
                                    Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8.0),
                                    width: SizeConfig.imageSizeMultiplier !* 3.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                    height: SizeConfig.imageSizeMultiplier !* 3.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                    child: Icon(Icons.account_circle_outlined, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 17),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 3.5),
                                Text("Bilhete: " + widget.student["student"]["personalData"]["bi"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("Nome: " + widget.student["student"]["personalData"]["fullName"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("Sexo: " + widget.student["student"]["personalData"]["gender"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("Data de nascimento: " + widget.student["student"]["personalData"]["birthdate"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5.5),
                                Text("N.º de processo: " + widget.student["student"]["process"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("N.º: " + widget.student["number"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("Turma: " + widget.student["classroom"]["name"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("Sala: " + widget.student["classroom"]["room"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                Text("Período: " + widget.student["classroom"]["period"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                                SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                Text("Contacto do Encarregado: ", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', )),
                                SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("TRIMESTRES: ", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          child: Text("I"),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                            primary: _selected1 ? Colors.white : Colors.black,
                                            backgroundColor: _selected1 ? Color(0xFF0D89A4) : Colors.white,
                                            textStyle: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              _selected1 = true;
                                              _selected2 = false;
                                              _selected3 = false;
                                            });
                                          }
                                        ),
                                        TextButton(
                                          child: Text("II"),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                            primary: _selected2 ? Colors.white : Colors.black,
                                            backgroundColor: _selected2 ? Color(0xFF0D89A4) : Colors.white,
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold
                                            )
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              _selected1 = false;
                                              _selected2 = true;
                                              _selected3 = false;
                                            });
                                          },
                                        ),
                                        TextButton(
                                          child: Text("III"),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                            primary: _selected3 ? Colors.white : Colors.black,
                                            backgroundColor: _selected3 ? Color(0xFF0D89A4) : Colors.white,
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold
                                            )
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              _selected1 = false;
                                              _selected2 = false;
                                              _selected3 = true;
                                            });
                                          },
                                        ),
                                      ],
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