import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/teacherModel.dart';

class SecondPage extends StatefulWidget {

  const SecondPage({ Key? key }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  final _formKey = GlobalKey<FormState>();

  String? _value;

  TextEditingController _email = TextEditingController();

  late TeacherModel? newTeacher;

  @override
  void initState(){
    super.initState();

    
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {  
      newTeacher = ModalRoute.of(context)?.settings.arguments as TeacherModel;
        
      if (newTeacher?.regimeLaboral != null){
        setState(() {
          _value = newTeacher?.regimeLaboral.toString();
        });
      }

      if (newTeacher?.email != null){
        _email.text = newTeacher!.email.toString();
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
                              buildMiddleNavigator(context, false, '/one', true),
                              buildMiddleNavigator(context, false, '/two', true),
                              buildMiddleNavigator(context, true, '/three', true),
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
                                buildTextFieldRegister("E-mail", TextInputType.emailAddress, _email),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                DropdownButtonFormField(
                                  hint: Text("Regime Laboral"),
                                  style: TextStyle(color: letterColor),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: fillColor,
                                    hintStyle: TextStyle(color: letterColor),
                                  ),
                                  dropdownColor: fillColor,
                                  items: [
                                    DropdownMenuItem(child: Text("Efectivo"), value: "Efectivo",),
                                    DropdownMenuItem(child: Text("Colaborador"), value: "Colaborador",),
                                  ],
                                  value: _value,
                                  onChanged: (newValue){
                                    setState(() {
                                      _value = newValue.toString();
                                    });
                                  },
                                  validator: (value) => value == null ? 'Preencha o campo Regime Laboral' : null,
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
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: arrowIconSize,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: normalTextStyleWhiteSmall),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newTeacher?.copyWith(email: _email.text, regimeLaboral: _value);
                                          Navigator.pushNamed(context, '/two', arguments: model);
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
                                              Text("Próximo", style: normalTextStyleWhiteSmall),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: arrowIconSize,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          if (_formKey.currentState!.validate()){
                                            var model = newTeacher?.copyWith(email: _email.text, regimeLaboral: _value);
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
                              child: Text("Já possui uma conta?", style: TextStyle(color: linKColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: normalTextSizeForSmallText)),
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