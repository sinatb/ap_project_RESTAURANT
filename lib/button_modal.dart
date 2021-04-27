import 'package:flutter/material.dart';
import 'package:restaurant/colors.dart';
class button_modal{
  static Widget button_model(String txt ,Color color , VoidCallback func)
  {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(18.0),
              )
          )
        ),
        onPressed: (){
          func();
        },
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 20,
            color: common_colors.black
          ),
        ),
    );
  }

}