import 'package:flutter/material.dart';
import 'package:models/models.dart';
class AddFood extends StatefulWidget {

  final VoidCallback rebuildMenu;
  AddFood(this.rebuildMenu):super();
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  FoodCategory f = FoodCategory.Iranian;
  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: Strings.get('add-bottom-sheet-food-name')!,
                  icon: Icon(Icons.fastfood_sharp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _price,
                decoration: InputDecoration(
                  hintText: Strings.get('add-bottom-sheet-food-price')!,
                  icon: Icon(Icons.attach_money_rounded),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DropdownButton<String>(
                value: f.toString().substring(13),
                onChanged: (String? newValue){
                  setState(() {
                    if (newValue == 'Iranian')
                      f = FoodCategory.Iranian;
                    else if (newValue == 'SeaFood')
                      f = FoodCategory.SeaFood;
                    else if (newValue == 'FastFood')
                      f=FoodCategory.FastFood;
                  });
                },
                items:<String>['Iranian', 'SeaFood', 'FastFood']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Center(
              child: buildModelButton('Create', CommonColors.green!, ()
              {
                createFood(_name.text,f,Price(int.parse(_price.text)));
                Navigator.pop(context);
              }
              ),
            )
          ],
        ));
      }
      void createFood(String name , FoodCategory f , Price p)
      {
        var s = (Head.of(context).server.account as OwnerAccount).restaurant;
        s.menu!.addFood(new Food(name: name , category: f , price: p , server: Head.of(context).server));
        widget.rebuildMenu();
      }
    }
