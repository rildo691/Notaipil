import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

class FourthPage extends StatefulWidget {

  const FourthPage({ Key? key }) : super(key: key);

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {

   @override
   Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    String? _value;

    TextEditingController _emailAluno = TextEditingController();
    TextEditingController _emailEncarregado = TextEditingController();

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
                          buildMiddleNavigator(context, false, '/first'),
                          buildMiddleNavigator(context, false, '/second'),
                          buildMiddleNavigator(context, false, '/third'),
                          buildMiddleNavigator(context, true, '/fourth'),
                        ]
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildTextFieldRegister("E-mail", TextInputType.emailAddress, _emailAluno),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            buildTextFieldRegister("E-mail do Encarregado", TextInputType.emailAddress, _emailEncarregado),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            Container(
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier !* 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildBackButton(context, '/third'),
                                  GestureDetector(
                                    child: Container(
                                      width: SizeConfig.screenWidth !* .32,
                                      height: SizeConfig.heightMultiplier !* 6,
                                      color: Color.fromRGBO(0, 209, 255, 0.49),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Finalizar", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                          SizedBox(width: 8.0),
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      _buildModal();
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
                            Navigator.pushNamed(context, '/');
                          }
                        )
                      )
                    ],
                  ),
                )
              )
            );
          }
        );
      },
    );
  }

  Future<Widget>? _buildModal(){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text("Obrigado por cadastrar-se, por favor aguarde uma resposta no seu e-mail.", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 209, 255, 0.49),
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){},
                )
              ]
            ),
          )
        );
      }
    );
  }
}