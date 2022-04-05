import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';
import 'dart:math';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';

class ShowAgendaState extends StatefulWidget {

  late int index;
  late var principal = [];

  ShowAgendaState(this.index, this.principal);

  @override
  _ShowAgendaStateState createState() => _ShowAgendaStateState();
}

class _ShowAgendaStateState extends State<ShowAgendaState> {

  var _value;
  int _selectedIndex = 3;
  int? informationLength;

  var _selected1 = true;
  var _selected2 = false;
  var _selected3 = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });

    setState(() {
      _selectedIndex = widget.index;
    });
  }

  var areas = [];
  var classrooms = [];

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
              key: _key,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: appBarLetterColorAndDrawerColor),
              ),
              drawer: Drawer(
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
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
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
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                          },
                          
                        ),
                        ListTile(
                          leading: Icon(Icons.group, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Pedidos de adesão', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
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
                child: FutureBuilder(
                  future: Future.wait([getClassroomsByArea(_value), getAreas()]),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          color: backgroundColor,
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

                          classrooms = (snapshot.data! as List)[0];
                          areas = (snapshot.data! as List)[1];

                          return 
                          
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            //height: classrooms.length > 6 ? SizeConfig.screenHeight !* classrooms.length / 7 : SizeConfig.screenHeight,
                            color: backgroundColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildHeaderPartTwo("Estado das minipautas"),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 7),
                                  DropdownButtonFormField<String>(
                                    hint: Text("Área de Formação"),
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: fillColor,
                                      ),
                                    dropdownColor: fillColor,
                                    items: areas.map((e) => 
                                      DropdownMenuItem<String>(
                                        value: e["id"],
                                        child: Text(e["name"].toString().length > 35 ? e["name"].toString().substring(0, 38) + "..." : e["name"].toString())
                                      )
                                    ).toList(),
                                    value: _value,
                                    onChanged: (newValue){
                                      classrooms.clear();
                                      setState(() {
                                        _value = newValue;
                                        getClassroomsByArea(_value);
                                      });
                                    },
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("FORMAÇÃO DAS MINIPAUTAS: ", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            child: Text("I"),
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                              primary: _selected1 ? Colors.white : letterColor,
                                              backgroundColor: _selected1 ? borderAndButtonColor : Colors.white,
                                              textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold)
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
                                              primary: _selected2 ? Colors.white : letterColor,
                                              backgroundColor: _selected2 ? borderAndButtonColor : Colors.white,
                                              textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold)
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
                                              primary: _selected3 ? Colors.white : letterColor,
                                              backgroundColor: _selected3 ? borderAndButtonColor: Colors.white,
                                              textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold)
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
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                  Expanded(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        DataTable(
                                          columns: [
                                            DataColumn(
                                              label: Text("TURMAS"),
                                              numeric: false,
                                            ),
                                            /*
                                            DataColumn(
                                              label: Text("MINIPAUTAS"),
                                              numeric: false,
                                            ),
                                            DataColumn(
                                              label: Text("PROGRESSO"),
                                              numeric: false,
                                            ),
                                            DataColumn(
                                              label: Text("ESTADO"),
                                              numeric: false,
                                            )*/
                                          ],
                                          rows: classrooms.map((e) => 
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(e["name"].toString())
                                                  ),
                                                )
                                              ]
                                            )
                                          ).toList(),
                                        ),
                                      ]
                                    ),
                                  )
                                ],
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.principal)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(index, widget.principal)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordinationTeachers(index, widget.principal)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAgendaState(index, widget.principal)));
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