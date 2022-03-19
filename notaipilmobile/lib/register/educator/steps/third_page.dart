import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/educatorModel.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';


class ThirdPage extends StatefulWidget {

  const ThirdPage({ Key? key }) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  final _formKey = GlobalKey<FormState>();

  String? _value;

  EducatorModel? newEducator;

  TextEditingController _email = TextEditingController();
  TextEditingController _telefone = TextEditingController();

  bool _isValid = false;

  @override
  void initState(){
    super.initState();
      
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newEducator = ModalRoute.of(context)?.settings.arguments as EducatorModel;

          if (newEducator?.email != null && newEducator?.telefone!= null){
            setState(() {
              _email.text = newEducator!.email.toString();
              _telefone.text = newEducator!.telefone.toString();
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
                              buildMiddleNavigator(context, false, '/two', false),
                              buildMiddleNavigator(context, true, '/three', false),
                              buildMiddleNavigator(context, false, '/four', false),
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
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: letterColor),
                                  decoration: InputDecoration(
                                    labelText: "Telefone",
                                    labelStyle: TextStyle(color: letterColor),
                                    filled: true,
                                    fillColor: fillColor,
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _telefone,
                                  validator: (String? value){
                                    if (value!.isEmpty){
                                      return "Preencha o campo Telefone";
                                    } 
                                    if (value.toString().length > 9 || value.toString().length < 9){
                                      return "Número de telefone deve possuir 9 dígitos";
                                    }
                                  }
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
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newEducator?.copyWith(email: _email.text, telefone: _telefone.text);
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
                                              Text("Próximo", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          if (_formKey.currentState!.validate()){
                                            var model = newEducator?.copyWith(email: _email.text, telefone: _telefone.text);
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