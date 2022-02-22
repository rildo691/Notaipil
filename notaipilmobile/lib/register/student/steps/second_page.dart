import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/register/model/studentModel.dart';

/**Models */
import 'package:notaipilmobile/register/model/areaModel.dart';
import 'package:notaipilmobile/register/model/courseModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class SecondPage extends StatefulWidget {

  const SecondPage({ Key? key }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  final _formKey = GlobalKey<FormState>();
  
  String? _value;
  String? _value2;

  late StudentModel? newStudent;

  var areas = [];
  var courses = [];

  @override
  void initState(){
    super.initState();

    getAreas().then((List<dynamic> value) => 
      setState((){
        areas = value;
      })
    );
    
    
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {  
      newStudent = ModalRoute.of(context)?.settings.arguments as StudentModel;
        
      if (newStudent?.areaFormacao != null && newStudent?.curso != null){
        setState(() {
          _value = newStudent?.areaFormacao.toString();
          _value2 = newStudent?.curso.toString();
        });
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
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: Color.fromARGB(255, 34, 42, 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHeaderPartOne(),
                          buildHeaderPartTwo("Cadastrar Aluno"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildMiddleNavigator(context, false, '/first', false),
                              buildMiddleNavigator(context, true, '/second', false),
                              buildMiddleNavigator(context, false, '/third', false),
                              buildMiddleNavigator(context, false, '/fourth', false),
                            ]
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButtonFormField<String>(
                                  hint: Text("Área de Formação"),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0xFF202733),
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                  dropdownColor: Colors.black,
                                  items: areas.map((e) {
                                    return new DropdownMenuItem<String>(
                                      value: e["id"].toString(),
                                      child: Text(e["name"].toString())
                                    );
                                  }).toList(),
                                  value: _value,
                                  onChanged: (newValue){
                                    _value = newValue.toString();
                                    courses.clear();
                                    getCoursesName(newValue.toString()).then((List<dynamic> value) => 
                                      setState((){
                                        courses = value;
                                      })
                                    );                                    
                                  },
                                  validator: (value) => value == null ? 'Preencha o campo Área de Formação' : null,
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                DropdownButtonFormField(
                                  hint: Text("Curso"),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0xFF202733),
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                  dropdownColor: Colors.black,
                                  items: courses.map((e) {
                                    return new DropdownMenuItem<String>(
                                      value: e["id"].toString(),
                                      child: Text(e["name"].toString())
                                    );
                                  }).toList(),
                                  value: _value2,
                                  onChanged: (newValue){
                                    _value2 = newValue.toString();
                                    courses.clear();
                                  },
                                  validator: (value) => value == null ? 'Preencha o campo Curso' : null,
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                Container(
                                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier !* 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: Color.fromRGBO(0, 209, 255, 0.49),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newStudent?.copyWith(areaFormacao: _value, curso: _value2);
                                          Navigator.pushNamed(context, '/first', arguments: model);
                                        },
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: Color.fromRGBO(0, 209, 255, 0.49),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Próximo", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          if (_formKey.currentState!.validate()){
                                            var model = newStudent?.copyWith(areaFormacao: _value, curso: _value2);
                                            Navigator.pushNamed(context, '/third', arguments: model);
                                          }
                                        },
                                      )
                                    ],  
                                  ),
                                )
                              ]
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: Text("Já possui uma conta?", style: TextStyle(color: Color(0xFF00D1FF), fontWeight: FontWeight.w200, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).pushNamed('/');
                              }
                            )
                          )
                        ],
                      ),
                    )
                  ]
                )
              )
            );
          }
        );
      },
    );
  }

  void buildItems(){

  }
}