import 'package:flutter/material.dart';
import 'package:notaipilmobile/configs/size_config.dart';

///Strings 
const String baseImageUrl = "http://10.0.2.2:9800/api/v1/profile/";
const String fontFamily = 'Roboto';

///Colors
const Color backgroundColor = Color(0xFFF5F6FA);
const Color fillColor = Color(0xFFF5F6FA);
const Color letterColor = Color(0xFF333333);
const Color linKColor = Color(0xFF0D89A4);
const Color appBarColor = Colors.white;
const Color drawerColor = Colors.white;
const Color borderAndButtonColor = Color(0xFF0D89B0);
const Color iconColor = Colors.black;
const Color profileIconColor = Colors.grey;
const Color teacherNameColor = Colors.red;
const Color informationNotSeen = Color.fromARGB(100, 248, 248, 248);
const Color informationSeen = Color.fromARGB(100, 231, 231, 231);
const Color informationSentIconColor = Color(0xFF198754);
const Color informationReceivedIconColor = Color(0xFF00A6B2);

///DateTime
final DateTime now = DateTime.now();

///Double
final double titleSize = SizeConfig.textMultiplier !* 4.5;

///TextStyle
const TextStyle normalTextStyle = TextStyle(color: letterColor, fontFamily: fontFamily,);