import 'package:flutter/material.dart';
import 'package:restaurant/colors.dart';
import 'package:restaurant/offline_test_food.dart';
class menu_page_widget
{

  static var test_menu =[
    new offline_test_food('pizza',10,Image.asset('assets/pictures/0817-murray-mancini-dried-tomato-pie.jpg'),true),
    new offline_test_food('fish',12,Image.asset('assets/pictures/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg'),true),
    new offline_test_food('pan cake', 5, Image.asset('assets/pictures/PSD_Food_illustrations_3190_pancakes_with_butter-1wi1tz5.jpg'),true),
    new offline_test_food('lasagna', 30, Image.asset('assets/pictures/140430115517-06-comfort-foods.jpg'), true)
  ];


  static Widget menu_page_grid_view_item(int index)
  {
    return GestureDetector(
        child:Container(
            decoration: BoxDecoration(
              color: common_colors.green,
              border: Border.all(
                  width: 4,
                  color: common_colors.red
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child:Text(
                test_menu.elementAt(index).name,
                style: TextStyle(color: common_colors.black,fontSize: 20),
              ),
            )
        )
      //implement on tap here
    );
  }

  static Widget menu_page_grid_view()
  {
    return GridView.builder(
      itemCount:test_menu.length ,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2
      ),
      itemBuilder:(BuildContext context,int index)
      {
        return menu_page_grid_view_item(index);
      },
    );
  }



}