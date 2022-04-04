import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

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
                      color: backgroundColor,
                      child: FutureBuilder(
                        future: Future.wait([getAreas(), getCoursesName(_value)]),
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
                                ),
                              );
                            default:
                              if (snapshot.hasError){
                                return Container();
                              } else {
                                areas = (snapshot.data! as List)[0];
                                courses = (snapshot.data! as List)[1];

                                return Column(
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
                                            style: TextStyle(color: letterColor),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
                                            ),
                                            dropdownColor: fillColor,
                                            items: areas.map((e) {
                                              return new DropdownMenuItem<String>(
                                                value: e["id"].toString(),
                                                child: Text(e["name"].toString())
                                              );
                                            }).toList(),
                                            value: _value,
                                            onChanged: (newValue){
                                              courses.clear();
                                              setState((){_value = newValue;});
                                              setState((){getCoursesCode(newValue);});
                                            },
                                            validator: (value) => value == null ? 'Preencha o campo Área de Formação' : null,
                                          ),
                                          SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                          DropdownButtonFormField(
                                            hint: Text("Curso"),
                                            style: TextStyle(color: letterColor),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
                                            ),
                                            dropdownColor: fillColor,
                                            items: courses.map((e) {
                                              return new DropdownMenuItem<String>(
                                                value: e["id"].toString(),
                                                child: Text(e["name"].toString())
                                              );
                                            }).toList(),
                                            value: _value2,
                                            onChanged: (newValue){
                                              _value2 = newValue.toString();
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
                                                    color: borderAndButtonColor,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.arrow_back_ios, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 4.7,),
                                                        SizedBox(width: 8.0),
                                                        Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
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
                                                    color: borderAndButtonColor,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Próximo", style: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                                        SizedBox(width: 8.0),
                                                        Icon(Icons.arrow_forward_ios, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 4.7,),
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
                                        child: Text("Já possui uma conta?", style: TextStyle(color: linKColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: SizeConfig.textMultiplier !* 2.7 - 2)),
                                        onTap: (){
                                          Navigator.of(context, rootNavigator: true).pushNamed('/');
                                        }
                                      )
                                    )
                                  ],
                                );
                              }
                          }
                        }
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
}