import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/studentModel.dart';

class FirstPage extends StatefulWidget {

  const FirstPage({Key? key }) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  StudentModel? newStudent;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _numeroBilhete = TextEditingController();
  TextEditingController _numeroProcesso = TextEditingController();

  @override
  void initState(){
    super.initState();

    setState((){
      
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newStudent = ModalRoute.of(context)?.settings.arguments as StudentModel;

          if (newStudent?.numeroBI != null && newStudent?.numeroProcesso!= null){
            _numeroBilhete.text = newStudent!.numeroBI.toString();
            _numeroProcesso.text = newStudent!.numeroProcesso.toString();
            
          }
        });
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
                      buildHeaderPartTwo("Cadastrar Aluno"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildMiddleNavigator(context, true, '/first'),
                          buildMiddleNavigator(context, false, '/second'),
                          buildMiddleNavigator(context, false, '/third'),
                          buildMiddleNavigator(context, false, '/fourth'),
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
                                      var model = StudentModel(numeroBI: _numeroBilhete.text, numeroProcesso: _numeroProcesso.text);
                                      Navigator.pushNamed(context, '/fourth', arguments: model);
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
                                        var model = StudentModel(numeroBI: _numeroBilhete.text, numeroProcesso: _numeroProcesso.text);
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