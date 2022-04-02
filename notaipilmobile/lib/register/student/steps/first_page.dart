import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/studentModel.dart';
import 'package:notaipilmobile/register/model/studentAccountModel.dart';
import 'package:notaipilmobile/register/model/typeAccountModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';


class FirstPage extends StatefulWidget {

  const FirstPage({Key? key }) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  StudentModel? newStudent;  

  ApiService helper = ApiService();

  final _formKey = GlobalKey<FormState>();  
  bool _isValid = false;

  TextEditingController _numeroBilhete = TextEditingController();
  TextEditingController _numeroProcesso = TextEditingController();

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      newStudent = ModalRoute.of(context)?.settings.arguments as StudentModel;

      if (newStudent?.numeroBI != null && newStudent?.numeroProcesso!= null){

        _numeroBilhete.text = newStudent!.numeroBI.toString();
        _numeroProcesso.text = newStudent!.numeroProcesso.toString();
            
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
                          buildHeaderPartTwo("Cadastrar Aluno"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildMiddleNavigator(context, true, '/first', false),
                              buildMiddleNavigator(context, false, '/second', false),
                              buildMiddleNavigator(context, false, '/third', false),
                              buildMiddleNavigator(context, false, '/fourth', false),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildTextFieldRegister("Nº do Bilhete de Identidade", TextInputType.text, _numeroBilhete),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                buildTextFieldRegister("Nº de Processo", TextInputType.number, _numeroProcesso),
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
                                          color: Colors.grey,
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
                                        onTap: () async{
                                          /*
                                          RegExp expression = RegExp(
                                            r"^/^[0-9]{9}[a-z]{2}[0-9]{3}$/"
                                          );
                                          if (expression.hasMatch(_numeroBilhete.text)){
                                            _isValid = true;
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: "N.º do bilhete de identidade inválido, tente novamente.",
                                              toastLength: Toast.LENGTH_LONG,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              gravity: ToastGravity.BOTTOM,
                                            ).toString();
                                          }*/
                                            if (_formKey.currentState!.validate()){
                                            var model = StudentModel(numeroBI: _numeroBilhete.text, numeroProcesso: int.parse(_numeroProcesso.text.toString()));
                                            Navigator.pushNamed(context, '/second', arguments: model);
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

