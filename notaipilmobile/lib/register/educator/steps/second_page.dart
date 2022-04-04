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
import 'package:notaipilmobile/register/model/educatorModel.dart';

/**User Interface */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class SecondPage extends StatefulWidget {

  const SecondPage({ Key? key }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  final _formKey = GlobalKey<FormState>();

  var _value;
  var _date;

  EducatorModel? newEducator;

  TextEditingController _dataNascimento = TextEditingController();

  @override
  void initState(){
    super.initState();
      
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newEducator = ModalRoute.of(context)?.settings.arguments as EducatorModel;

          if (newEducator?.sexo != null && newEducator?.dataNascimento != null){
            setState(() {
              _dataNascimento.text = newEducator!.dataNascimento.toString();
              _value = newEducator!.sexo.toString();
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
                              buildMiddleNavigator(context, false, '/one', false),
                              buildMiddleNavigator(context, true, '/two', false),
                              buildMiddleNavigator(context, false, '/three', false),
                              buildMiddleNavigator(context, false, '/four', false),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButtonFormField(
                                  hint: Text("Sexo"),
                                  style: TextStyle(color: letterColor),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: fillColor,
                                    hintStyle: TextStyle(color: letterColor),
                                  ),
                                  dropdownColor: fillColor,
                                  items: [
                                    DropdownMenuItem(child: Text("Masculino"), value: "M",),
                                    DropdownMenuItem(child: Text("Feminino"), value: "F",),
                                  ],
                                  value: _value,
                                  onChanged: (newValue){
                                    setState((){
                                      _value = newValue.toString();
                                    });
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
                                          var model = newEducator?.copyWith(sexo: _value, dataNascimento: _date);
                                          Navigator.pushNamed(context, '/one', arguments: model);
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
                                            var model = newEducator?.copyWith(sexo: _value, dataNascimento: _date);
                                            Navigator.pushNamed(context, '/three', arguments: model);
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