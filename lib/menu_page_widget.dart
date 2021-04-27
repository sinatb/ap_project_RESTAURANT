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


  static Widget menu_page_grid_view_item(int index,BuildContext context)
  {
    return GestureDetector(
        child:Container(
            decoration: BoxDecoration(
              color: common_colors.generate_rnd_color() as Color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child:Text(
                test_menu.elementAt(index).name,
                style: TextStyle(color: common_colors.black,fontSize: 20),
              ),
            )
        ),
        onTap:(){
          menu_page_bottom_sheet(context,index);
          } ,
      //implement on tap here
    );
  }



  static void menu_page_bottom_sheet(BuildContext context,int index)
  {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context){
        return Container(
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     test_menu.elementAt(index).image,
                     Container(
                       padding: EdgeInsets.all(20),
                       child: TextFormField(
                         decoration: InputDecoration(
                           icon: Icon(Icons.drive_file_rename_outline)
                         ),
                         initialValue: test_menu.elementAt(index).name,
                       ),
                     ),
                     Container(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.monetization_on)
                        ),
                        initialValue: test_menu.elementAt(index).price.toString() + " tomans",
                      ),
                    )

                  ],
              ),
            )
        );
      }
    );
  }



  static Widget menu_page_grid_view(BuildContext context)
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
        return menu_page_grid_view_item(index,context);
      },
    );
  }


}