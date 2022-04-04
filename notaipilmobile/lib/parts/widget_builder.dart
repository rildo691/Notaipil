import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

Widget buildTextFormField(String hint, TextInputType type, TextEditingController controller, maxL, {isReadOnly}){
    return TextFormField(
      keyboardType: type,
      maxLines: maxL ? int.parse((SizeConfig.heightMultiplier !* .9).toInt().toString()) : null,
      readOnly: isReadOnly != null ? isReadOnly ? true : false : false,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: letterColor, fontFamily: fontFamily), textAlign: TextAlign.start,
      controller: controller,
      validator: (String? value){
        if (value!.isEmpty){
          return "Preencha o campo $hint";
        }
      }
    );
}

Widget buildPasswordFormFieldWithIcon(hint, controller){
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.white,),
        labelText: hint,
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: controller,
      validator: (String? value){
        return "Preencha o campo $hint";
      },
    );
  }

  Widget buildTextFormFieldWithIcon(String hint, TextInputType type, TextEditingController controller, maxL, {icon}){
    return TextFormField(
      keyboardType: type,
      maxLines: maxL ? int.parse((SizeConfig.heightMultiplier !* .9).toInt().toString()) : null,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: hint,
        labelStyle: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.black, fontFamily: 'Roboto'), textAlign: TextAlign.start,
      controller: controller,
      validator: (String? value){
        return "Preencha o campo $hint";
      }
    );
  }