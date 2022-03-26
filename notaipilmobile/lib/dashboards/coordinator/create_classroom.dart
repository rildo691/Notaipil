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

/**Model */
import 'package:notaipilmobile/register/model/classroomModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

class CreateClassroom extends StatefulWidget {

  late var coordinator = [];

  CreateClassroom(this.coordinator);

  @override
  _CreateClassroomState createState() => _CreateClassroomState();
}

class _CreateClassroomState extends State<CreateClassroom> {

  int _selectedIndex = 0;

  TextEditingController _codeController = TextEditingController();
  TextEditingController _roomController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ClassroomModel? classroom;

  var _periodValue;
  var _placeValue;
  var _courseValue;
  var _gradeValue;
  var coursesLength;
  var _courseCode;
  var _gradeCode;
  var area = [];
  var courses = [];
  var grades = [];

  String? _areaId;
  
  @override
  void initState(){
    super.initState();

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
              ),              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !* 1.07,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: Future.wait([getCoursesByArea(_areaId), getGrade()]),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D89A4)),
                              strokeWidth: 5.0,
                            )
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            courses = (snapshot.data! as List)[0];
                            grades = (snapshot.data! as List)[1];
                            
                            return
                             Form(
                              key: _key,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Criar turma"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField(
                                            hint: Text("Curso"),
                                            style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color(0xFF202733),
                                              hintStyle: TextStyle(color: Colors.white),
                                            ),
                                            dropdownColor: Colors.black,
                                            items: courses.map((e) => 
                                              DropdownMenuItem<String>(
                                                value: e["id"],
                                                child: Text(e["code"].toString()),
                                              )
                                            ).toList(),
                                            value: _courseValue,
                                            onChanged: (newValue){
                                              setState((){
                                                _courseValue = newValue;
                                                getCourseById(_courseValue).then((value) => setState((){_courseCode = value[0]["code"];}));
                                              });
                                            },
                                            validator: (value) => value == null ? 'Preencha o campo Curso' : null,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField(
                                            hint: Text("Classe"),
                                            style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color(0xFF202733),
                                              hintStyle: TextStyle(color: Colors.white),
                                            ),
                                            dropdownColor: Colors.black,
                                            items: grades.map((e) => 
                                              DropdownMenuItem<String>(
                                                value: e["id"],
                                                child: Text(e["name"].toString() + "ª"),
                                              )
                                            ).toList(),
                                            value: _gradeValue,
                                            onChanged: (newValue){
                                              setState((){
                                                _gradeValue = newValue;
                                                getGradeById(_gradeValue).then((value) => setState((){_gradeCode = value[0]["name"];}));
                                              });
                                            },
                                            validator: (value) => value == null ? 'Preencha o campo Classe' : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 8,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      prefix: Text(_courseCode != null && _gradeCode != null ? _courseCode.toString() + _gradeCode.toString() : "", style: TextStyle(color: Colors.white),),
                                      labelText: "Código",
                                      labelStyle: TextStyle(color: Colors.white),
                                      filled: true,
                                      fillColor: Color(0xFF202733),
                                      border: OutlineInputBorder(),
                                    ),
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: _codeController,
                                    validator: (String? value){
                                      return "Preencha o campo Código";
                                    },
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  buildTextFieldRegister("Sala", TextInputType.number, _roomController),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier !* 3,
                                  ),
                                  DropdownButtonFormField(
                                    hint: Text("Localização"),
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
                                        _placeValue = newValue;
                                      });
                                    },
                                    validator: (value) => value == null ? 'Preencha o campo Localização' : null,
                                  ),
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
                                      if (_key.currentState!.validate()){
                                        classroom = ClassroomModel(
                                          room: _roomController.text,
                                          code: _codeController.text,
                                          period: _periodValue.toString(),
                                          place: _placeValue.toString(),
                                          gradeId: _gradeValue.toString(),
                                          courseId: _courseValue.toString()
                                        );
                                      
                                        var response = await helper.postWithoutToken("classrooms", classroom!.toJson());
                                        
                                      }
                                    },
                                  )
                                ]
                              ),
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

  Future<Widget>? buildModal(context, message){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(widget.coordinator)));
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