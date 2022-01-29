import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

Widget buildTextFormField(String hint, TextInputType type, TextEditingController controller, maxL){
    return TextFormField(
      keyboardType: type,
      maxLines: maxL ? int.parse((SizeConfig.heightMultiplier !* .9).toInt().toString()) : null,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
        filled: true,
        fillColor: Color(0xFF202733),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.white, fontFamily: 'Roboto'), textAlign: TextAlign.start,
      controller: controller,
      validator: (String? value){
        return "Preencha o campo $hint";
      }
    );
  }