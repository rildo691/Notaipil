import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:intl/intl.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/teacherModel.dart';

/**User Interface */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class FifthPage extends StatefulWidget {

  const FifthPage({ Key? key }) : super(key: key);

  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  
  final _formKey = GlobalKey<FormState>();

  String? _value;

  TeacherModel? newTeacher;

  var _date;

  TextEditingController _nomeCompleto = TextEditingController();
  TextEditingController _dataNascimento = TextEditingController();


  @override
  void initState() {
    super.initState();

        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newTeacher = ModalRoute.of(context)?.settings.arguments as TeacherModel;

          if (newTeacher?.nome != null && newTeacher?.sexo != null && newTeacher?.dataNascimento != null){
            setState(() {
              _nomeCompleto.text = newTeacher!.nome.toString();
              _value = newTeacher!.sexo.toString();
              _dataNascimento.text = newTeacher!.dataNascimento.toString();
            });
          } else {
            _dataNascimento.text = "";
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
                      padding: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 25.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: backgroundColor,
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
                              buildMiddleNavigator(context, true, '/one', true),
                              buildMiddleNavigator(context, false, '/two', true),
                              buildMiddleNavigator(context, false, '/three', true),
                              buildMiddleNavigator(context, false, '/four', true),
                              buildMiddleNavigator(context, false, '/fifth', true),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildTextFieldRegister("Nome Completo", TextInputType.text, _nomeCompleto),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                DropdownButtonFormField(
                                  hint: Text("Sexo"),
                                  style: TextStyle(color: letterColor),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: fillColor,
                                    hintStyle: TextStyle(color: letterColor),
                                  ),
                                  dropdownColor: Colors.black,
                                  items: [
                                    DropdownMenuItem(child: Text("Masculino"), value: "M",),
                                    DropdownMenuItem(child: Text("Feminino"), value: "F",),
                                  ],
                                  value: _value,
                                  onChanged: (newValue){
                                    _value = newValue.toString();
                                  },
                                  validator: (value) => value == null ? 'Preencha o campo Sexo' : null,
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                DateTimeField(
                                  decoration: InputDecoration(
                                    labelText: "Data de Nascimento",
                                    suffixIcon: Icon(Icons.event_note, color: iconColor),
                                    labelStyle: TextStyle(color: letterColor),
                                  ),
                                  controller: _dataNascimento,
                                  format: DateFormat("yyyy-MM-dd"),
                                  style:  TextStyle(color: letterColor),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      locale: const Locale("pt"),
                                      firstDate: DateTime(1900),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                    ).then((date){
                                      setState((){
                                        _dataNascimento.text = date.toString();
                                        _date = date;
                                      });
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier !* 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: Colors.grey,
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
                                              Text("Próximo", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          if (_formKey.currentState!.validate()){
                                            var model = TeacherModel(nome: _nomeCompleto.text, sexo: _value, dataNascimento: _date);
                                            Navigator.pushNamed(context, '/two', arguments: model);
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
                              child: Text("Já possui uma conta?", style: TextStyle(color: linKColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).pushNamed('/');
                              }
                            )
                          )
                        ],
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