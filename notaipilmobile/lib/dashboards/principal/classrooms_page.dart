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
  var _value;
  var _stringValue;
  var _courseValue;
  var _gradeValue;
  var _studentClassroom = [];

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

  @override
  void initState(){
    super.initState();

    getAreas().then((List<dynamic> value) =>
      setState((){
        areas = value;
      })
    );    

    setState(() {
      _value = widget.value;
      _stringValue = widget.value["area"];
    });
    

    getCourses(widget.value["id"]).then((List<dynamic> value) => 
      setState((){
        courses = value;
      })
    );
  }

  Future _getStudents(classroom) async{
    var response = await helper.get("classroom_students/$classroom");

    for (var r in response){
      setState(() {
        if (_studentClassroom.length < 5){
          _studentClassroom.add(r);
        }
      });
    }

    return _studentClassroom;
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
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
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
                            child: Text(e["name"].toString().length > 35 ? e["name"].toString().substring(0, 25) + "..." : e["name"].toString())
                          )
                        ).toList(),
                        value: _stringValue,
                        onChanged: (newValue){
                          courses.clear();
                          getCourses(newValue).then((List<dynamic> value) => 
                            setState((){
                              courses = value;
                            })
                          );
                          _stringValue = newValue.toString();
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
                                style: TextStyle(color: Colors.white),
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
                                    child: Text(e["name"].toString()),
                                  )
                                ).toList(),
                                value: _courseValue,
                                onChanged: (newValue){
                                  setState((){
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
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.black,
                                items: grades.map((e) => 
                                  DropdownMenuItem<String>(
                                    value: e["id"],
                                    child: Text(e["name"].toString()),
                                  )
                                ).toList(),
                                value: _gradeValue,
                                onChanged: (newValue){
                                  _studentClassroom.clear();
                                  _getStudents(_gradeValue);
                                  setState((){
                                    _gradeValue = newValue;
                                  });
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
                          ? Color(0xFF00D1FF) : Color(0xFF00D1FF)
                        ),
                        
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
                        rows: _fakeStudents.map((e) => 
                          DataRow(
                            cells: [
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.imageSizeMultiplier !* .5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                    height: SizeConfig.imageSizeMultiplier !* .5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,)),
                                )
                              ),
                              DataCell(
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.widthMultiplier !* .5,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(e['numero'].toString(), textAlign: TextAlign.center)
                                  ),
                                ),
                                showEditIcon: false,
                                placeholder: true,
                              ),
                              DataCell(
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.widthMultiplier !* .5,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(e['processo'].toString(), textAlign: TextAlign.center)
                                  ),
                                ),
                                showEditIcon: false,
                                placeholder: true,
                              ),
                              DataCell(
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: SizeConfig.widthMultiplier !* 1,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(e['nomeCompleto'].toString(), textAlign: TextAlign.left)
                                  ),
                                ),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.widthMultiplier !* 1,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(e['sexo'].toString(), textAlign: TextAlign.center)
                                  ),
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
                      )
                    ]  
                  )
                ),
              ),
            );
          },
        );
      },
    );
  }
}