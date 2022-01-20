import 'dart:async';

import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complemtnts */
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';

/**User Interface */
import 'package:carousel_slider/carousel_slider.dart';

/**Model */
import 'package:notaipilmobile/register/model/areaModel.dart';
import 'package:notaipilmobile/register/model/courseModel.dart';
import 'package:notaipilmobile/register/model/gradeModel.dart';

/**Complemtnts */
import 'package:notaipilmobile/dashboards/principal/show_classroom_page.dart';


class ClassroomsPage extends StatefulWidget {

  late Map<dynamic, dynamic> value;

  ClassroomsPage(this.value);

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

  var _fakeStudents = [
    {
      'photo': 'none',
      'numero': '1',
      'processo': '12345',
      'nomeCompleto': 'António João da Silva Mateus',
      'sexo': 'M'
    }, 
    {
      'photo': 'none',
      'numero': '2',
      'processo': '12345',
      'nomeCompleto': 'Maria de Oliveira dos Santos',
      'sexo': 'F'
    },
    {
      'photo': 'none',
      'numero': '3',
      'processo': '12345',
      'nomeCompleto': 'Pedro Sungo Rozinho João',
      'sexo': 'M'
    },
    {
      'photo': 'none',
      'numero': '4',
      'processo': '12345',
      'nomeCompleto': 'Bruno Fortunato Domingos Mateus',
      'sexo': 'M'
    },
    {
      'photo': 'none',
      'numero': '5',
      'processo': '12345',
      'nomeCompleto': 'Rildo William de Melo Franco',
      'sexo': 'M'
    }
  ];

  ApiService helper = ApiService();

  int _currentPos = 0;
  int _selectedIndex = 0;

  String? _classroomId;

  bool _classroomsExists = false;

  @override
  void initState(){
    super.initState();

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
                    padding: EdgeInsets.only(right: 20.0),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){},
                  )
                ],
              ),
              drawer: Navbar(),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: Future.wait([getAreas(), getCoursesCode(_value), getGrade(), getClassroom(_courseValue, _gradeValue), getClassroomStudent(_classroomId)]),
                    //stream: _getData(),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting: 
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>( Color(0xFF0D89A4)),
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
                                  DropdownButtonFormField<String>(
                                    hint: Text(_stringValue.toString().length > 35 ? _stringValue.toString().substring(0, 25) + "..." : _stringValue.toString()),
                                    style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Color(0xFF202733),
                                      ),
                                    dropdownColor: Colors.black,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: SizeConfig.widthMultiplier !* 30,
                                        child: SizedBox(
                                          child: DropdownButtonFormField<String>(
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
                                  DataTable(
                                    dataRowColor: MaterialStateColor.resolveWith((states) => 
                                      states.contains(MaterialState.selected) ? Color.fromARGB(255, 34, 42, 55) : Color.fromARGB(255, 34, 42, 55)
                                    ),
                                    dataTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.2 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                    showBottomBorder: true,
                                    dividerThickness: 5,
                                    headingTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                    headingRowColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) 
                                      ? Color(0xFF0D89A4) : Color(0xFF0D89A4)
                                    ),
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
                                            Center(child: Icon(Icons.account_circle, color: Colors.white,),)
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text("1", textAlign: TextAlign.center)
                                            ),
                                            showEditIcon: false,
                                            placeholder: true,
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(e['process'].toString(), textAlign: TextAlign.center)
                                            ),
                                            showEditIcon: false,
                                            placeholder: true,
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(e['fullName'].toString(), textAlign: TextAlign.left)
                                            ),
                                            showEditIcon: false,
                                            placeholder: false,
                                          ),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(e['gender'].toString(), textAlign: TextAlign.center)
                                            ),
                                            showEditIcon: false,
                                            placeholder: false,
                                          ),
                                        ]
                                      ),
                                    ).toList(),
                                  ),
                                  GestureDetector(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Ver mais", style: TextStyle(color: Color(0xFF00D1FF), fontWeight: FontWeight.w200, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowClassroomPage(_classroomId.toString())));
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
                                          color: _currentPos == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)
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
                                  SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  DropdownButtonFormField<String>(
                                    hint: Text(_stringValue.toString().length > 35 ? _stringValue.toString().substring(0, 25) + "..." : _stringValue.toString()),
                                    style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Color(0xFF202733),
                                      ),
                                    dropdownColor: Colors.black,
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
                                            style: TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color(0xFF202733),
                                              hintStyle: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
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
                                      child: Text("Por favor, selecione um Curso e uma Classe", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),)
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
                                  SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                  DropdownButtonFormField<String>(
                                    hint: Text(_stringValue.toString().length > 35 ? _stringValue.toString().substring(0, 25) + "..." : _stringValue.toString()),
                                    style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Color(0xFF202733),
                                      ),
                                    dropdownColor: Colors.black,
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
                                            style: TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Color(0xFF202733),
                                              hintStyle: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
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
                                      child: Text("Infelizmente não conseguimos encontrar uma turma para esse Curso e essa Classe. Tente novamente!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),)
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

  Widget _classroomLinks(classroomName, classroomId, index){
    return GestureDetector(
      child: Container(
        width: SizeConfig.widthMultiplier !* 25,
        height: 8.0,
          child: ElevatedButton(
            child: Text(classroomName.toString()),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF0D89A4),
              onPrimary: Colors.white,
              textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
            ),
            onPressed: (){
              setState((){
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