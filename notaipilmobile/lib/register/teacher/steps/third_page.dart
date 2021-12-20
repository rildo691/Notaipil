import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

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

  Future getQualifications() async{
    var response = await helper.get("qualifications");

    for(var r in response){
      Map<String, dynamic> map = {
        "id": QualificationsModel.fromJson(r).id,
        "name": QualificationsModel.fromJson(r).name,
      };

      setState((){
        qualifications.add(map);
      });
    }
  }

  @override
  void initState(){
    super.initState();

    getQualifications();
    
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color(0xFF202733),
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
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color(0xFF202733),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              dropdownColor: Colors.black,
                              items: qualifications.map((e){
                                return new DropdownMenuItem<String>(
                                  value: e["id"].toString(),
                                  child: Text(e["name"].toString()),
                                );
                              }).toList(),
                              value: _value,
                              onChanged: (newValue){
                                _value = newValue.toString();
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
                                      var model = newTeacher?.copyWith(habilitacoes: _value, categoria: _categoria.text);
                                      Navigator.pushNamed(context, '/three', arguments: model);
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