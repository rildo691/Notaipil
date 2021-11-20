import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

class ThirdPage extends StatefulWidget {

  const ThirdPage({ Key? key }) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    String? _value;

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
                          buildMiddleNavigator(context, true, '/third'),
                          buildMiddleNavigator(context, false, '/fourth'),
                        ]
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildDropdownFormField("Classe", _value),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            buildDropdownFormField("Turma", _value),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            Container(
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier !* 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildBackButton(context, '/second'),
                                  buildForwardButton(context, '/fourth')
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
}