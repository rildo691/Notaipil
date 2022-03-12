import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Fucntions*/
import 'package:notaipilmobile/parts/header.dart';

class AccountType extends StatelessWidget {

  const AccountType({ Key? key }) : super(key: key);

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
                          buildHeaderPartTwo("Tipo de Conta"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildAccountButton(context, "Professor", '/teacher'),
                              _buildAccountButton(context, "Aluno", '/student')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildAccountButton(context, "Encarregado", '/educator'),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 130.0),
                            child: GestureDetector(
                              child: Text("Já possui uma conta?", style: TextStyle(color: linKColor, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                              onTap: (){
                                Navigator.pushNamed(context, '/');
                              }
                            )
                          ),
                        ],
                      ),
                    )
                  ]
                )
              )
            );
          }
        );
      },
    );
  }

  Widget _buildAccountButton(context, String text, String route){
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.account_circle, color: iconColor, size: 25.0),
          SizedBox(width: 10,),
          Text(text, style: TextStyle(color: letterColor, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.w400), textAlign: TextAlign.center)
        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, route);
      },
    );
  }
}