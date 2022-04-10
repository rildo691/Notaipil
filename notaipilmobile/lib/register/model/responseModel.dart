import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/parts/variables.dart';

Future<Widget>? buildModal(context, error, message, {route}){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                error ? Icon(Icons.error_outline, size: 70.0, color: Colors.red) : Icon(Icons.check_circle_outline, size: 70.0, color: Colors.green),
                Text(message, style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: borderAndButtonColor,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    error ? Navigator.pop(context) : Navigator.pushNamed(context, route);
                  },
                )
              ]
            ),
          )
        );
      }
    );
}   

Future<Widget>? buildModalMaterialPage(context, error, message, MaterialPageRoute route){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                error ? Icon(Icons.error_outline, size: 70.0, color: Colors.red) : Icon(Icons.check_circle_outline, size: 70.0, color: Colors.green),
                Text(message, style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: borderAndButtonColor,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    error ? Navigator.pop(context) : Navigator.push(context, route);
                  },
                )
              ]
            ),
          )
        );
      }
    );
} 

