import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_classroom_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';

/**User Interface */
import 'package:carousel_slider/carousel_slider.dart';

/**Model */
import 'package:notaipilmobile/register/model/areaModel.dart';
import 'package:notaipilmobile/register/model/courseModel.dart';
import 'package:notaipilmobile/register/model/gradeModel.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';



class ClassroomsPage extends StatefulWidget {

  late int value;
  late var principal = [];

  ClassroomsPage(this.value, this.principal);

  @override
  _ClassroomsPageState createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {

  var areas = [];
  var courses = [];
  var grades = [];
  var classrooms = [];
  var students = [];
  var classroomsFake = [];
  var _value;
  var _stringValue;
  var _courseValue;
  var _courseCode;
  var _gradeValue;
  var _gradeCode;
  var _studentClassroom = [];
  var fullData = [];

  ApiService helper = ApiService();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _currentPos = 0;
  int _selectedIndex = 1;
  int? informationLength;

  String? _classroomId;

  bool _classroomsExists = false;
  bool _clicked = false;

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));

    setState((){
      _selectedIndex = widget.value;
    });

    /*
    getGrade().then((List<dynamic> value) =>
      setState((){
        grades = value;
        _gradeValue = grades[3]["id"];
        _gradeCode = grades[3]["name"] + "ª";
      })
    );

    setState(() {
      _value = widget.value["id"];
      _stringValue = widget.value["area"];
    });
    
    
    getCoursesCode(widget.value["id"]).then((List<dynamic> value) => 
      setState((){
        courses = value;
        _courseValue = courses[0]["id"];
        _courseCode = courses[0]["name"];
      })
    );*/
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
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: Future.wait([getAreas(), getCoursesCode(_value), getGrade(), getClassroom(_courseValue, _gradeValue), getClassroomStudent(_classroomId)]),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
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
                          if (snapshot.hasError)
                            return Container();
                          else {
                            areas = (snapshot.data! as List)[0];
                            courses = (snapshot.data! as List)[1];
                            grades = (snapshot.data! as List)[2];

                            if ((snapshot.data! as List)[3] != null){
                              classrooms = (snapshot.data! as List)[3];
                            }

                            if ((snapshot.data! as List)[4] != null){
                              students.clear();
                              students = (snapshot.data! as List)[4];
                            }
                          
                            if (classrooms.isNotEmpty){
                              return 
                              Column (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildHeaderPartTwo("Turmas"),
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
                                      courses.clear();         
                                      classrooms.clear();
                                      students.clear();
                                      _courseValue = null;
                                      _gradeValue = null;   
                                      _classroomId = null;   
                                      _classroomsExists = false;                     
                                      setState(() {
                                        _value = newValue.toString();
                                      });
                                      getCoursesCode(newValue).then((value) => setState((){courses = value;}));
                                    }
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
                                            hint: Text("Curso"),
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
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
                                              classrooms.clear();
                                              students.clear();
                                              _classroomId = null;
                                              setState(() {
                                                _courseValue = newValue;
                                              });
                                            }
                                          )
                                        )
                                      ),
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
                                            hint: Text("Classe"),
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: Colors.white),
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
                                              classrooms.clear();
                                              students.clear();
                                              _classroomId = null;
                                              setState((){
                                                _gradeValue = newValue;
                                              });
                                              getClassroom(_courseValue, newValue);
                                              _classroomsExists = true;
                                            }
                                          )
                                        )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                  DataTable(
                                    columnSpacing: SizeConfig.widthMultiplier !* 3,
                                    columns: [
                                      DataColumn(
                                        label: Text(""),
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: Text("N.º"),
                                        numeric: true
                                      ),
                                      DataColumn(
                                        label: Text("Proc."),
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: Text("Nome Completo"),
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: Text("Sexo"),
                                        numeric: false,
                                      )
                                    ],
                                    rows: students.map((e) => 
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Center(child: Icon(Icons.account_circle, color: profileIconColor,),)
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(e["number"].toString(), textAlign: TextAlign.center)
                                            ),
                                            showEditIcon: false,
                                            placeholder: true,
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(e["student"]['process'].toString(), textAlign: TextAlign.center)
                                            ),
                                            showEditIcon: false,
                                            placeholder: true,
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(e["student"]["personalData"]['fullName'].toString(), textAlign: TextAlign.left)
                                            ),
                                            showEditIcon: false,
                                            placeholder: false,
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(e["student"]["personalData"]['gender'].toString(), textAlign: TextAlign.center)
                                            ),
                                            showEditIcon: false,
                                            placeholder: false,
                                          ),
                                        ]
                                      ),
                                    ).toList(),
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  GestureDetector(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Ver mais", style: TextStyle(color: !_clicked ? Colors.grey : linKColor, fontWeight: FontWeight.w200, fontFamily: 'Roboto', fontSize: SizeConfig.textMultiplier !* 2.7 - 2)),
                                    ),
                                    onTap: (){
                                      if (_clicked){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomPage(_classroomId.toString(), widget.principal)));
                                      }
                                    }
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 2),
                                  CarouselSlider.builder(
                                    itemCount: classrooms.length,
                                    options: CarouselOptions(
                                      height: SizeConfig.heightMultiplier !* 7,
                                      autoPlayAnimationDuration: Duration(seconds: 5),
                                      autoPlay: false,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason){
                                        _currentPos = index;
                                      }
                                    ),
                                    itemBuilder: (context, index, _){
                                      for (int i = 0; i < classrooms.length; i++){
                                        if(classrooms[i]["id"] == _classroomId){
                                          for (int j = 0; j < i; j++){
                                            classrooms.insert(j+1, classrooms.removeAt(j));
                                          }
                                          break;
                                        }
                                      }
                                      return _classroomLinks(classrooms[index]["name"], classrooms[index]["id"], index);
                                    },
                                  ),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: classrooms.map((e) {
                                      int index = classrooms.indexOf(e);
                                      return Container(
                                        width: 8.0,   
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: iconColor
                                        ),
                                      );  
                                    }).toList()
                                  )
                                ],
                              );
                            } else if (classrooms.isEmpty && !_classroomsExists) {
                              return 
                              Column (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildHeaderPartTwo("Turmas"),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 7),
                                  DropdownButtonFormField<String>(
                                    hint: Text("Área de Formação"),
                                    style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: fillColor,
                                        hintStyle: TextStyle(color: letterColor),
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
                                      courses.clear();         
                                      classrooms.clear();
                                      _courseValue = null;
                                      _gradeValue = null;  
                                      _classroomsExists = false;                         
                                      setState(() {
                                        _value = newValue.toString();
                                      });
                                      getCoursesCode(newValue).then((value) => setState((){courses = value;}));
                                    }
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
                                            hint: Text("Curso"),
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
                                              classrooms.clear();
                                              setState(() {
                                                _courseValue = newValue;
                                              });
                                            }
                                          )
                                        )
                                      ),
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
                                            hint: Text("Classe"),
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
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
                                              classrooms.clear();
                                              setState((){
                                                _gradeValue = newValue;
                                              });
                                              getClassroom(_courseValue, newValue);
                                              _classroomsExists = true;
                                            }
                                          )
                                        )
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text("Por favor, selecione um Curso e uma Classe", textAlign: TextAlign.center, style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 3.4, fontWeight: FontWeight.bold),)
                                    )
                                  )
                                ]  
                              );  
                            } else {
                              return 
                              Column (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildHeaderPartTwo("Turmas"),
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
                                      courses.clear();         
                                      classrooms.clear();
                                      _courseValue = null;
                                      _gradeValue = null; 
                                      _classroomsExists = false;                          
                                      setState(() {
                                        _value = newValue.toString();
                                      });
                                      getCoursesCode(newValue).then((value) => setState((){courses = value;}));
                                    }
                                  ),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
                                            hint: Text("Curso"),
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
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
                                              classrooms.clear();
                                              setState(() {
                                                _courseValue = newValue;
                                              });
                                              getClassroom(_courseValue, _gradeValue);
                                              _classroomsExists = true;
                                            }
                                          )
                                        )
                                      ),
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
                                            hint: Text("Classe"),
                                            style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
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
                                              classrooms.clear();
                                              setState((){
                                                _gradeValue = newValue;
                                              });
                                              getClassroom(_courseValue, newValue);
                                              _classroomsExists = true;
                                            }
                                          )
                                        )
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text("Infelizmente não conseguimos encontrar uma turma para esse Curso e essa Classe. Tente novamente!", textAlign: TextAlign.center, style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 3.4, fontWeight: FontWeight.bold),)
                                    )
                                  )
                                ]  
                              );
                            }
                          }      
                      }
                    }
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
                onTap:(int index){
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

  Widget _classroomLinks(classroomName, classroomId, index){
    return GestureDetector(
      child: Container(
        width: SizeConfig.widthMultiplier !* 25,
        height: 8.0,
          child: ElevatedButton(
            child: Text(classroomName.toString()),
            style: ElevatedButton.styleFrom(
              primary: borderAndButtonColor,
              onPrimary: Color.fromRGBO(255, 255, 255, 1),
              textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)
            ),
            onPressed: (){
              setState((){
                _clicked = true;
                setState((){_classroomId = classroomId;});
                students.clear();
                getClassroomStudent(_classroomId).then((value) => students = value);
              });
            },
          ),
        ),
    ); 
  }
}