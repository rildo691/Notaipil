import 'dart:io';

import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/teacherModel.dart';
import 'package:notaipilmobile/register/model/qualificationsModel.dart';

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

  TextEditingController _categoria = TextEditingController();
  ApiService helper = ApiService();
  

  late TeacherModel? newTeacher;

  var qualifications = [];

  

  @override
  void initState(){
    super.initState();

    getQualifications().then((List<dynamic> value) => 
      setState((){
        qualifications = value;
      })
    );
    
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {  
      newTeacher = ModalRoute.of(context)?.settings.arguments as TeacherModel;
        
      if (newTeacher?.habilitacoes != null && newTeacher?.categoria != null){
        setState(() {
          _value = newTeacher?.habilitacoes.toString();
          _value2 = newTeacher?.categoria.toString();
          _categoria.text = _value2.toString();
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
                        future: getQualifications(),
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
                                qualifications = (snapshot.data! as List);

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildHeaderPartOne(),
                                    buildHeaderPartTwo("Cadastrar Professor"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        buildMiddleNavigator(context, false, '/one', true),
                                        buildMiddleNavigator(context, false, '/two', true),
                                        buildMiddleNavigator(context, false, '/three', true),
                                        buildMiddleNavigator(context, true, '/four', true),
                                        buildMiddleNavigator(context, false, '/fifth', true),
                                      ],
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DropdownButtonFormField<String>(
                                            hint: Text("Habilitações Literárias"),
                                            style: TextStyle(color: letterColor),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: fillColor,
                                              hintStyle: TextStyle(color: letterColor),
                                            ),
                                            dropdownColor: fillColor,
                                            items: qualifications.map((e){
                                              return new DropdownMenuItem<String>(
                                                value: e["id"].toString(),
                                                child: Text(e["name"].toString()),
                                              );
                                            }).toList(),
                                            value: _value,
                                            onChanged: (newValue){
                                              setState(() {
                                                _value = newValue.toString();
                                              });
                                            },
                                            validator: (value) => value == null ? 'Preencha o campo Habilitações Literárias' : null,
                                          ),
                                          SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                          buildTextFieldRegister("Categoria", TextInputType.text, _categoria),
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
                                                    var model = newTeacher?.copyWith(habilitacoes: _value, categoria: _categoria.text);
                                                    Navigator.pushNamed(context, '/three', arguments: model);
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
                                                      var model = newTeacher?.copyWith(habilitacoes: _value, categoria: _categoria.text);
                                                      Navigator.pushNamed(context, '/fifth', arguments: model);
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
                ),
              )
            );
          }
        );
      },
    );
  }
}