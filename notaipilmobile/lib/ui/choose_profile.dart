import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

class Chooseprofile extends StatefulWidget {

  const Chooseprofile({ Key? key }) : super(key: key);

  @override
  _ChooseprofileState createState() => _ChooseprofileState();
}

class _ChooseprofileState extends State<Chooseprofile> {

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
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 35.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color(0xFF202733),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeaderPartOne(),
                      buildHeaderPartTwo("Escolha o seu perfil"),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        children: [
                          _buildCard("Professor"),                                        
                          _buildCard("Aluno"),
                          _buildCard("Coordenador"),
                          _buildCard("Director"),
                        ]
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 1.7,),
                      Container(
                        child: Icon(Icons.power_settings_new_sharp, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1)
                      ),
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

  Widget _buildCard(String text){
    return GestureDetector(
      child: Card(
        color: Color(0xFF222A37),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                  height: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                ),
                SizedBox(height: SizeConfig.heightMultiplier !* 2.3),
                Text(text, style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
              ],
            ),
          )
        )
      ),
    );
  }
}