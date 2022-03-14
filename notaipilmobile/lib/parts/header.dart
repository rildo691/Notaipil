import 'package:flutter/material.dart';
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/parts/variables.dart';

Widget buildHeaderPartOne(){
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          width: SizeConfig.imageSizeMultiplier !* 3.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
          height: SizeConfig.imageSizeMultiplier !* 3.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
          child: Image.asset('assets/images/ipil-logo.png', fit: BoxFit.cover,),
        ),
                            
        Text("NotaIPIL", style: TextStyle(color: letterColor, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center), 
      ]
    ),
  );
}

Widget buildHeaderPartTwo(String text){
  return Container(
    child: Text(text, style: TextStyle(color: letterColor, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 4.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 5.5, fontFamily: 'Roboto', fontWeight: FontWeight.w100), textAlign: TextAlign.center), 
  );
}

