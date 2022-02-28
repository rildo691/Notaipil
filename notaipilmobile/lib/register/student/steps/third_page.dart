import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/studentModel.dart';
import 'package:notaipilmobile/register/model/gradeModel.dart';
import 'package:notaipilmobile/register/model/classroomModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class ThirdPage extends StatefulWidget {

  const ThirdPage({ Key? key }) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  final _formKey = GlobalKey<FormState>();

  String? _value;
  String? _value2;

  String? curso;

  late StudentModel? newStudent;

  var grades = [];
  var classrooms = [];

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {  
      newStudent = ModalRoute.of(context)?.settings.arguments as StudentModel;

      if (newStudent?.classe != null && newStudent?.turma != null){
        setState((){
          _value = newStudent?.classe.toString();
          _value2 = newStudent?.turma.toString();
        });
      }

      if (newStudent?.curso != null){
        setState((){
          curso = newStudent?.curso.toString();
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: Future.wait([getGrade(), getClassroom(newStudent!.curso, _value)]),
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
                            ),
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            grades = (snapshot.data! as List)[0];
                            classrooms = (snapshot.data! as List)[1];
                            
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
                                    buildMiddleNavigator(context, false, '/second', false),
                                    buildMiddleNavigator(context, true, '/third', false),
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
                                        hint: Text("Classe"),
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Color(0xFF202733),
                                          hintStyle: TextStyle(color: Colors.white),
                                        ),
                                        dropdownColor: Colors.black,
                                        items: grades.map((e) {
                                          return new DropdownMenuItem<String>(
                                            value: e["id"],
                                            child: Text(e["name"] + "ª".toString())
                                          );
                                        }).toList(),
                                        value: _value,
                                        onChanged: (newValue){
                                          classrooms.clear();
                                          setState(() {
                                            _value = newValue.toString();
                                          });
                                          getClassroom(newStudent!.classe, newValue);
                                        },
                                        validator: (value) => value == null ? 'Preencha o campo Classe' : null,
                                      ),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                      DropdownButtonFormField(
                                        hint: Text("Turma"),
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Color(0xFF202733),
                                          hintStyle: TextStyle(color: Colors.white),
                                        ),
                                        dropdownColor: Colors.black,
                                        items: classrooms.map((e) {
                                          return new DropdownMenuItem<String>(
                                            value: e["id"],
                                            child: Text(e["name"].toString())
                                          );
                                        }).toList(),
                                        value: _value2,
                                        onChanged: (newValue){
                                          setState(() {
                                            _value2 = newValue.toString();
                                          });
                                        },
                                        validator: (value) => value == null ? 'Preencha o campo Turma' : null,
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
                                                var model = newStudent?.copyWith(classe: _value, turma: _value2);
                                                Navigator.pushNamed(context, '/second', arguments: model);
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
                                                  var model = newStudent?.copyWith(classe: _value, turma: _value2);
                                                  Navigator.pushNamed(context, '/fourth', arguments: model);
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
                            );
                          }
                      }
                    },
                  ),
                )
              )
            );
          }
        );
      },
    );
  }
}