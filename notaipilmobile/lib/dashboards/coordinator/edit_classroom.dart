import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_classroom_page.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/add_delete_student.dart';
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/students_list.dart';

class EditClassroom extends StatefulWidget {

  late String classroomId;
  late var coordinator = [];

  EditClassroom(this.classroomId, this.coordinator);

  @override
  _EditClassroomState createState() => _EditClassroomState();
}

class _EditClassroomState extends State<EditClassroom> {

  String? _classroomName;
  int _selectedIndex = 0;
  String? _areaId;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _roomController = TextEditingController();
  TextEditingController _placeController = TextEditingController();

  var _periodValue;
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
        _placeController.text = value[0]["place"].toString();
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
                        accountName: new Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                        accountEmail: new Text(widget.coordinator[0]["personalData"]["gender"] == "M" ? widget.coordinator[0]["courses"].length == coursesLength ? "Coordenador da Área de ${area[0]["name"]}" : "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : widget.coordinator[0]["courses"].length == coursesLength ? "Coordenadora da Área de ${area[0]["name"]}" : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
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
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('Estudantes', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsList(widget.coordinator)))
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
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 110.7,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: 
                      Form(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Editar Turma"),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.widthMultiplier !* 10,
                                    height: SizeConfig.heightMultiplier !* 4,
                                    child: Icon(Icons.person, color: Colors.white)
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddDeleteStudent(widget.coordinator)));
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
                            buildTextFieldRegister("Localização", TextInputType.text, _placeController),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 3,
                            ),
                            DropdownButtonFormField(
                              hint: Text("Período"),
                              style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color(0xFF202733),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              dropdownColor: Colors.black,
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
                                  value: "Tarde",
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
                                    primary:  Color(0xFF0D89A4),
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 20.0,
                                    ),
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
                                primary:  Color(0xFF0D89A4),
                                onPrimary: Colors.white,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 20.0,
                                ),
                              minimumSize: Size(0.0, 50.0),
                              ),
                              onPressed: () async{
                                Map<String, dynamic> body = {
                                  "room": _roomController.text,
                                  "period": _periodValue.toString(),
                                  "place": _placeController.toString(),
                                };

                                var response = await helper.patch("classrooms/", widget.classroomId, body);
                                buildConfirmationModal("Alterações feitas com sucesso.");
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