import 'package:flutter/material.dart';
import 'package:notaipilmobile/configs/size_config.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:notaipilmobile/parts/variables.dart';

Widget buildTextFieldRegister(String hint, TextInputType type, TextEditingController controlador, {Icon? icon}){
  return TextFormField(
    keyboardType: type,
    style: TextStyle(color: letterColor),
    decoration: InputDecoration(
      prefixIcon: icon,
      labelText: hint,
      labelStyle: TextStyle(color: letterColor),
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(),
    ),
    controller: controlador,
    validator: (String? value){
      bool isValid = false;

      if (type == TextInputType.emailAddress && value!.isNotEmpty){
        isValid = EmailValidator.validate(value);

        if (!isValid){
          Fluttertoast.showToast(
            msg: "E-mail inválido, tente novamente",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          ).toString();

          return "E-mail inválido.";
        }
      }

      if (value!.isEmpty){
        return "Preencha o campo $hint";
      }
    },
  );
}

Widget buildDropdownFormField(String hint, String? _value){
  return DropdownButtonFormField(
    hint: Text(hint),
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: Colors.white),
    ),
    items: [
      DropdownMenuItem(child: Text("Teste"), value: "Teste1",),
      DropdownMenuItem(child: Text("Teste"), value: "Teste2",),
    ],
    value: _value,
    onChanged: (newValue){
      _value = newValue.toString();
    },
    validator: (value) => value == null ? 'Preencha o campo $hint' : null,
  );
}

Widget buildBackButton(context, String route, ){
  return GestureDetector(
    child: Container(
      width: SizeConfig.screenWidth !* .32,
      height: SizeConfig.heightMultiplier !* 6,
      color: borderAndButtonColor,
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
      color: borderAndButtonColor,
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

Widget buildMiddleNavigator(context, active, String route, bool width){
  if (width){
    return GestureDetector(
    child: Container(
      width: SizeConfig.widthMultiplier !* 15,
      height: SizeConfig.heightMultiplier !* .4,
      color: active? letterColor : Colors.grey,
    ),
    onTap: (){
      Navigator.pushNamed(context, route);
    },
  );
  } else {
    return GestureDetector(
    child: Container(
      width: SizeConfig.widthMultiplier !* 20,
      height: SizeConfig.heightMultiplier !* .4,
      color: active? letterColor : Colors.grey,
    ),
    onTap: (){
      Navigator.pushNamed(context, route);
    },
  );
  }
}