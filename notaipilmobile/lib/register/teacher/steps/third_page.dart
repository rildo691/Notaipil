import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/teacherModel.dart';

class ThirdPage extends StatefulWidget {

  const ThirdPage({ Key? key }) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  final _formKey = GlobalKey<FormState>();

  String? _value;
  String? _value2;
  

  late TeacherModel? newTeacher;

  @override
  void initState(){
    super.initState();

    
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {  
      newTeacher = ModalRoute.of(context)?.settings.arguments as TeacherModel;
        
      if (newTeacher?.habilitacoes != null && newTeacher?.categoria != null){
        setState(() {
          _value = newTeacher?.habilitacoes.toString();
          _value2 = newTeacher?.categoria.toString();
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
                  color: Colors.blueGrey.shade900,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeaderPartOne(),
                      buildHeaderPartTwo("Cadastrar Professor"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildMiddleNavigator(context, false, '/one'),
                          buildMiddleNavigator(context, false, '/two'),
                          buildMiddleNavigator(context, true, '/three'),
                          buildMiddleNavigator(context, false, '/four'),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButtonFormField(
                              hint: Text("Habilitações Literárias"),
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color(0xFF202733),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              dropdownColor: Colors.black,
                              items: [
                                DropdownMenuItem(child: Text("Diurno"), value: "Diurno",),
                                DropdownMenuItem(child: Text("Nocturno"), value: "Nocturno",),
                              ],
                              value: _value,
                              onChanged: (newValue){
                                _value = newValue.toString();
                              },
                              validator: (value) => value == null ? 'Preencha o campo Habilitações Literárias' : null,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                            DropdownButtonFormField(
                              hint: Text("Categoria"),
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color(0xFF202733),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              dropdownColor: Colors.black,
                              items: [
                                DropdownMenuItem(child: Text("Diurno"), value: "Diurno",),
                                DropdownMenuItem(child: Text("Nocturno"), value: "Nocturno",),
                              ],
                              value: _value2,
                              onChanged: (newValue){
                                _value2 = newValue.toString();
                              },
                              validator: (value) => value == null ? 'Preencha o campo Categoria' : null,
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
                                      var model = newTeacher?.copyWith(habilitacoes: _value, categoria: _value2);
                                      Navigator.pushNamed(context, '/two', arguments: model);
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
                                        var model = newTeacher?.copyWith(habilitacoes: _value, categoria: _value2);
                                        Navigator.pushNamed(context, '/four', arguments: model);
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
                ),
              )
            );
          }
        );
      },
    );
  }
}