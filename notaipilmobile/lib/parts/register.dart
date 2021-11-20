import 'package:flutter/material.dart';
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/parts/header.dart';

Widget buildTextFieldRegister(String hint, TextInputType type){
  return TextFormField(
    keyboardType: type,
    decoration: InputDecoration(
      labelText: hint,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Color(0xFF202733),
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildBackButton(context, String route){
  return GestureDetector(
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
      Navigator.pushNamed(context, route);
    },
  );
}

Widget buildForwardButton(context, String route){
  return GestureDetector(
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
      Navigator.pushNamed(context, route);
    },
  );
}

Widget buildMiddleNavigator(active, String route){
  return GestureDetector(
    child: Container(
      width: SizeConfig.widthMultiplier !* 20,
      height: SizeConfig.heightMultiplier !* .4,
      color: active? Colors.white : Colors.grey,
    ),
  );
}