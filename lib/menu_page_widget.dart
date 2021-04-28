import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:restaurant/main_page.dart';
import 'package:models/models.dart';

class menu_page_widget
{

  static Widget menu_page_grid_view_item(int index,BuildContext context)
  {
    return GestureDetector(
        child:Container(
            decoration: BoxDecoration(
              color: CommonColors.generateColor() as Color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child:Text(
                test_menu.elementAt(index).name,
                style: TextStyle(color: CommonColors.black,fontSize: 20),
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
                    ),
                    // how should we change main_page state here ?
                    buildModelButton("delete food", CommonColors.red as Color, (){
                      test_menu.remove(index);
                      print(test_menu);
                    })
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