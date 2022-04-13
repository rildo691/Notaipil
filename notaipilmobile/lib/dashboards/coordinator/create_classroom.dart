import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';
import 'package:badges/badges.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Model */
import 'package:notaipilmobile/register/model/classroomModel.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

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
<<<<<<< HEAD
  int informationLength = 0;
=======
  int? informationLength;
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

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

    getUnreadInformations(widget.coordinator[2]["userId"], widget.coordinator[2]["typeAccount"]["id"]).then((value) {
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
              key: _scaffoldKey,
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
                        accountName: new Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        accountEmail: new Text(widget.coordinator[0]["courses"].length == coursesLength ? widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador da Área de " + widget.coordinator[1]["name"] : "Coordenadora da Área de " + widget.coordinator[1]["name"] : widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        currentAccountPicture: new ClipOval(
                          child: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.coordinator[0]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: borderAndButtonColor,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Informações', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
<<<<<<< HEAD
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
=======
                        trailing: informationLength !> 0 ?
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
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.coordinator)))
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
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !* 1.07,
                  color: backgroundColor,
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
                              valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                              strokeWidth: 5.0,
                            )
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            if (widget.coordinator[0]["courses"].length == coursesLength){
                              courses = (snapshot.data! as List)[0];
                            } else {
                              courses = widget.coordinator[0]["courses"];
                            }
                            
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
                                            hint: Text("Curso", style: TextStyle(color: letterColor, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                            ),
                                            dropdownColor: fillColor,
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
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                            ),
                                            dropdownColor: fillColor,
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
                                      prefix: Text(_courseCode != null && _gradeCode != null ? _courseCode.toString() + _gradeCode.toString() : "", style: TextStyle(color: letterColor, fontFamily: fontFamily),),
                                      labelText: "Código",
                                      labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                      filled: true,
                                      fillColor: fillColor,
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
                                      if (_key.currentState!.validate()){
                                        classroom = ClassroomModel(
                                          room: _roomController.text,
                                          code: _codeController.text,
                                          period: _periodValue.toString(),
                                          place: _placeValue.toString(),
                                          gradeId: _gradeValue.toString(),
                                          courseId: _courseValue.toString()
                                        );
                                      
                                        var response = await helper.post("classrooms", classroom!.toJson());
                                        buildModalMaterialPage(context, response["error"], response["message"], MaterialPageRoute(builder: (context) => ClassroomsPage(widget.coordinator)));
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