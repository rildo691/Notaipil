import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'dart:math';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

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

class SelectCoordinatorPage extends StatefulWidget {
  late var principal = [];
  late var information = [];

  SelectCoordinatorPage(this.principal, this.information);

  @override
  _SelectCoordinatorPageState createState() => _SelectCoordinatorPageState();
}

class _SelectCoordinatorPageState extends State<SelectCoordinatorPage> {

  TextEditingController _nameController = TextEditingController();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int index = 0;
  int? informationLength;

  var coordinators = [];
  var recipients = [];

  List<bool>? _selected;
  bool isFull = false;
  bool active = false;

  @override
  void initState(){
    super.initState();

     getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));

    setState((){
      _selected = List<bool>.generate(5, (index) => false);
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
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: Colors.white),),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
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
                  padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 20.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 50,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: getAllCoordinations(),
                    builder:(context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D89A4)),
                              strokeWidth: 5.0,
                            ),
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            if (!active){
                              coordinators = (snapshot.data! as List);
                            }

                            if (!isFull){
                              _selected = List<bool>.generate(coordinators.length, (index) => false);
                              isFull = true;
                            }

                            return 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Selecione o destinatário", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Pesquise o Nome",
                                    labelStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                                    filled: true,
                                    fillColor: Color(0xFF202733),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(color: Colors.white, fontFamily: 'Roboto'), textAlign: TextAlign.start,
                                  controller: _nameController,
                                  onFieldSubmitted: (String? value) {
                                    if (value!.isNotEmpty){
                                      setState((){
                                        active = true;
                                      });
                                      _filter(value);
                                    }
                                  },
                                  onChanged: (value){
                                    if (value.isEmpty){
                                      getAllCoordinations().then((value) => setState((){coordinators = value;}));
                                      setState((){
                                        isFull = false;
                                        active = false;
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
                                        columnSpacing: SizeConfig.widthMultiplier !* 9,
                                        columns: [
                                          DataColumn(
                                            label: Text(""),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Coordenador"),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Área de F."),
                                            numeric: false,
                                          ),
                                        ],
                                        rows: List<DataRow>.generate(coordinators.length, (index) => 
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: ClipOval(
                                                    child: coordinators[index]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + coordinators[index]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9.5, height: SizeConfig.imageSizeMultiplier !* 9),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(coordinators[index]["coordinator"]),
                                                )
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(coordinators[index]["areaName"]),
                                                )
                                              ),
                                            ],
                                            selected: _selected![index],
                                            onSelectChanged: (bool? value){
                                              _selected![index] = value!;
                                              setState((){});
                                            },
                                          )
                                        ),
                                      ),
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
                                      primary: Color(0xFF0D89A4),
                                      onPrimary: Colors.white,
                                      textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                                    ),
                                    onPressed: () async{
                                      for (int i = 0; i < _selected!.length; i++){
                                        if (_selected![i] != false){
                                          recipients.add(coordinators[i]["email"]);
                                        }
                                      }

                                      Map<String, dynamic> body = {
                                        "title": widget.information[0]["subject"].toString(),
                                        "description": widget.information[0]["message"].toString(),
                                        "userId": widget.principal[2]["userId"],
                                        "typeAccountId":  widget.principal[2]["typeAccount"]["id"],
                                        "group": "Coordenador",
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
                    }
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage( widget.principal)));
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
    getCoordinatorsByName(value).then((valueF) => setState((){coordinators = valueF;}));
    setState(() {
      isFull = false;
    });
  }
}