import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/variables.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';
import 'package:http/http.dart' as http;

/**Complements */
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';


class SelectTeachersPage extends StatefulWidget {
  late var principal = [];
  late var information = [];

  SelectTeachersPage(this.principal, this.information);

  @override
  _SelectTeachersPageState createState() => _SelectTeachersPageState();
}

class _SelectTeachersPageState extends State<SelectTeachersPage> {

  TextEditingController _nameController = TextEditingController();

  bool isFull = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<bool>? _selected;
  bool _firstTime = true;

  int _selectedIndex = 0;
  int? informationLength;

  var teachers = [];
  var recipients = [];

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));
    getAllTeachers().then((value) => setState((){teachers = value.toList();}));
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
              key: _key,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 9) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9, height: SizeConfig.imageSizeMultiplier !* 9),
                    onPressed: (){
                      _key.currentState!.openDrawer();
                    },
                  )
                ],
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 42, 55),
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
                            ),
                          ],
                          decoration: BoxDecoration(
                            color: drawerColor,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications, color: Colors.white,),
                          title: Text('Informações', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                          },
                          
                        ),
                        ListTile(
                          leading: Icon(Icons.group, color: Colors.white,),
                          title: Text('Pedidos de adesão', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: Colors.white,),
                          title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.white,),
                          title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
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
                    ),
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: start(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight !* 2,
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

                            if (!isFull){
                              _selected = List<bool>.generate(teachers.length, (index) => false);
                              isFull = true;
                            }
                            
                            return 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Selecione o destinatário", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                  decoration: InputDecoration(
                                    labelText: "Pesquise o Nome ou B.I.",
                                    labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    filled: true,
                                    fillColor: fillColor,
                                    border: OutlineInputBorder(),
                                  ),
                                  controller:  _nameController,
                                  validator: (String? value){
                                    if (value!.isEmpty){
                                      return "Preencha o campo Pesquise o Nome";
                                    }
                                  },
                                  onFieldSubmitted: (String? value) {
                                    if (value!.isNotEmpty){
                                      _filter(value);
                                    }
                                  },
                                  onChanged: (value){
                                    if (value.isEmpty){
                                      getAllTeachers().then((value) => setState((){teachers = value;}));
                                      setState((){
                                        isFull = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      DataTable(
                                        showCheckboxColumn: true,
                                        columnSpacing: SizeConfig.widthMultiplier !* 3,
                                        columns: [
                                          DataColumn(
                                            label: Text(""),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Professores"),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("B.I."),
                                            numeric: false,
                                          ),
                                        ],
                                        rows: List<DataRow>.generate(teachers.length, (index) => 
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: ClipOval(
                                                    child: teachers[index]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + teachers[index]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9.5, height: SizeConfig.imageSizeMultiplier !* 9),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(teachers[index]["teacherAccount"]["personalData"]["fullName"].toString())
                                                )
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(teachers[index]["teacherAccount"]["personalData"]["bi"].toString())
                                                )
                                              )
                                            ],
                                            selected: _selected![index],
                                            onSelectChanged: (bool? value){
                                              _selected![index] = value!;
                                              setState(() {
                                                getAllTeachers();
                                              });
                                            }
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                Container(
                                  width: SizeConfig.widthMultiplier !* 30,
                                  height: SizeConfig.heightMultiplier !* 7,
                                  child: ElevatedButton(
                                    child: Text("Confirmar"),
                                    style: ElevatedButton.styleFrom(
                                      primary: borderAndButtonColor,
                                      onPrimary: Colors.white,
                                      textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                                    ),
                                    onPressed: () async{
                                      for (int i = 0; i < _selected!.length; i++){
                                        if (_selected![i] != false){
                                          recipients.add(teachers[i]["teacherAccount"]["email"]);
                                        }
                                      }

                                      Map<String, dynamic> body = {
                                        "title": widget.information[0]["subject"].toString(),
                                        "description": widget.information[0]["message"].toString(),
                                        "userId": widget.principal[2]["userId"],
                                        "typeAccountId":  widget.principal[2]["typeAccount"]["id"],
                                        "group": "Professor",
                                        "usersDestiny": recipients
                                      };

                                      var response = await helper.post("informations", body);
                                      buildModalMaterialPage(context, response["error"], response["message"], MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)));
                                    },
                                  ),
                                )
                              ],
                            );
                          }      
                      }    
                    },
                  )
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.principal)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(index, widget.principal)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordinationTeachers(index, widget.principal)));
                      break;
                    case 3:
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

  _filter(value){
    getAllTeachersByName(value).then((value) => setState((){teachers = value;}));
    setState(() {
      isFull = false;
    });
  }
}
