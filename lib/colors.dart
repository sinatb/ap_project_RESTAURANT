import 'package:flutter/material.dart';
import 'dart:math';
class common_colors{
  static Color? pink = Colors.pink[200];
  static Color? blue = Colors.blueAccent[400];
  static Color? green = Colors.greenAccent[400];
  static Color? red = Colors.redAccent[400];
  static Color? black = Colors.black;
  static Color? cyan = Color(0xFF00E5FF);


  static  var color_rnd_list=[
      common_colors.green,
      common_colors.red,
      common_colors.pink,
      common_colors.cyan,
      common_colors.blue,
  ];
  //random color generator method to be implemented
  static Color? generate_rnd_color()
  {
    Random rnd = new Random();
    return color_rnd_list[rnd.nextInt(4)];
  }
}