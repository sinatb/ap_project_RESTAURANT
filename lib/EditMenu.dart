import 'package:flutter/material.dart';
import 'package:models/models.dart';

class EditMenu extends StatefulWidget {
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  Widget menu_page_grid_view_item(
      int index, BuildContext context, var testMenu) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
            color: CommonColors.generateColor() as Color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              testMenu.elementAt(index).name,
              style: TextStyle(color: CommonColors.black, fontSize: 20),
            ),
          )),
      onTap: () {
        menu_page_bottom_sheet(context, index, testMenu);
      },
//implement on tap here
    );
  }

  void menu_page_bottom_sheet(BuildContext context, int index, var testMenu) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: SingleChildScrollView(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //testMenu.elementAt(index).image,
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline)),
                    initialValue: testMenu.elementAt(index).name,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    decoration:
                        InputDecoration(icon: Icon(Icons.monetization_on)),
                    initialValue:
                        testMenu.elementAt(index).price.toString() + " tomans",
                  ),
                ),
                  // how should we change main_page state here ?
                buildModelButton("delete food", CommonColors.red as Color, () {
                  testMenu.removeAt(index);
                  print(testMenu);
                }),
                buildModelButton("edit food", CommonColors.green as Color, (){
                  print("edited");
                })
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
  var testMenu = (Head.of(context).server.account as OwnerAccount).restaurant.menu!.getFoods(FoodCategory.Iranian);
  return GridView.builder(
      itemCount:testMenu!.length ,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2
      ),
      itemBuilder:(BuildContext context,int index)
      {
        return menu_page_grid_view_item(index,context,testMenu);
      },
    );
  }
}

