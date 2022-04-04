import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/add_delete_student.dart';
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_classroom_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

class EditClassroom extends StatefulWidget {

  late String classroomId;
  late var coordinator = [];

  EditClassroom(this.classroomId, this.coordinator);

  @override
  _EditClassroomState createState() => _EditClassroomState();
}

class _EditClassroomState extends State<EditClassroom> {

  int _selectedIndex = 0;
  int? informationLength;

  String? _classroomName;
  String? _areaId;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _roomController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _periodValue;
  var _placeValue;
  var coursesLength;
  var area = [];
  var classroom = [];

  @override
  void initState(){
    super.initState();

    getClassroomById(widget.classroomId).then((value) => 
      setState((){
        classroom = value;
        _nameController.text = value[0]["name"].toString();
        _roomController.text = value[0]["room"].toString();
        _placeValue = value[0]["place"].toString();
        _periodValue = value[0]["period"].toString();
      })
    );

    setState(() {
      _areaId = widget.coordinator[0]["courses"][0]["areaId"];
    });

    getAreaById(widget.coordinator[0]["courses"][0]["areaId"]).then((value) =>
      setState((){
        area = value;
      })
    );

    getCoursesByArea(widget.coordinator[0]["courses"][0]["areaId"]).then((value) => 
      setState((){
        coursesLength = value.length;
      })
    );

    getUnreadInformations(widget.coordinator[2]["userId"], widget.coordinator[2]["typeAccount"]["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 9) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9, height: SizeConfig.imageSizeMultiplier !* 9),
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
                        accountName: new Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                        accountEmail: new Text(widget.coordinator[0]["courses"].length == coursesLength ? widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador da Área de " + widget.coordinator[1]["name"] : "Coordenadora da Área de " + widget.coordinator[1]["name"] : widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new ClipOval(
                          child: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.coordinator[0]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 34, 42, 55),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white,),
                        title: Text('Informações', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
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
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.coordinator)))
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 60,
                  color: backgroundColor,
                  child: 
                      Form(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Editar Turma", style: TextStyle(color: letterColor, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.widthMultiplier !* 10,
                                    height: SizeConfig.heightMultiplier !* 4,
                                    child: Icon(Icons.person, color: iconColor)
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddDeleteStudent(widget.classroomId, widget.coordinator)));
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 8,
                            ),
                            buildTextFieldRegister("Nome", TextInputType.text, _nameController),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 3,
                            ),
                            buildTextFieldRegister("Sala", TextInputType.number, _roomController),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 3,
                            ),
                            DropdownButtonFormField(
                              hint: Text("Localização"),
                              style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: fillColor,
                                hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                              ),
                              dropdownColor: fillColor,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Edifício"),
                                  value: "Edifício",
                                ),
                                DropdownMenuItem(
                                  child: Text("Pavilhões"),
                                  value: "Pavilhões",
                                )
                              ],
                              value: _placeValue,
                              onChanged: (newValue){
                                setState((){
                                  _periodValue = newValue;
                                });
                              },
                              validator: (value) => value == null ? 'Preencha o campo Localização' : null,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 3,
                            ),
                            DropdownButtonFormField(
                              hint: Text("Período"),
                              style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: fillColor,
                                hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                              ),
                              dropdownColor: fillColor,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Manhã"),
                                  value: "Manhã",
                                ),
                                DropdownMenuItem(
                                  child: Text("Tarde"),
                                  value: "Tarde",
                                ),
                                DropdownMenuItem(
                                  child: Text("Noite"),
                                  value: "Noite",
                                ),
                              ],
                              value: _periodValue,
                              onChanged: (newValue){
                                setState((){
                                  _periodValue = newValue;
                                });
                              },
                              validator: (value) => value == null ? 'Preencha o campo Período' : null,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 5,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text("Horário"),
                                  style: ElevatedButton.styleFrom(
                                    primary:  borderAndButtonColor,
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                    minimumSize: Size(0.0, 50.0),
                                  ),
                                  onPressed: (){
                                
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 6,
                            ),
                            ElevatedButton(
                              child: Text("Concluir"),
                              style: ElevatedButton.styleFrom(
                                primary:  borderAndButtonColor,
                                onPrimary: Colors.white,
                                textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                minimumSize: Size(0.0, 50.0),
                              ),
                              onPressed: () async{
                                Map<String, dynamic> body = {
                                  "room": _roomController.text,
                                  "period": _periodValue.toString(),
                                  "place": _placeValue.toString(),
                                };

                                var response = await helper.patch("classrooms/", body, id: widget.classroomId);
                                buildModalMaterialPage(context, response["error"], response["error"], MaterialPageRoute(builder: (context) => ShowClassroomPage(widget.classroomId, widget.coordinator)));
                              },
                            )
                          ]
                        ),
                      ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.coordinator)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(widget.coordinator)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordination(widget.coordinator)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAgendaState(widget.coordinator)));
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

  Future<Widget>? buildConfirmationModal(message){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text(message, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 209, 255, 0.49),
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomPage(widget.classroomId, widget.coordinator)));
                  },
                )
              ]
            )
          ),
        );
      }
    );
  }
}