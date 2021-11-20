import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {  //Responsive class
  // Size calculation vars
  static double? screenWidth;
  static double? screenHeight;
  static double? _blockWidth = 0;
  static double? _blockHeight = 0;
  // Multipliers, will be used in the UI
  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  // Detects orientation
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    
    if (orientation == Orientation.portrait) {  // If Portrait mode
      screenWidth = constraints.maxWidth;  // Device screen max avilable width
      screenHeight = constraints.maxHeight; // Device screen max avilable height
      isPortrait = true;
      if (screenWidth !< 450) {  // Device is smartphone
        isMobilePortrait = true;
      }

      print(screenWidth);
      print(screenHeight);
    } else {                                    // Landscape mode
      screenWidth = constraints.maxWidth; // Actual height will be width in landscape
      screenHeight = constraints.maxHeight; // and vice versa
      isPortrait = false;
      isMobilePortrait = false;

      print(screenWidth);
      print(screenHeight);
    }

    // Calculate blocks
    _blockWidth = screenWidth !/ 100;
    _blockHeight = screenHeight !/ 100;

    // Asign values to multipliers
    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    // Print width and height for debugging and size calculation
    //print(_blockWidth);
    //print(_blockHeight);
  }
}