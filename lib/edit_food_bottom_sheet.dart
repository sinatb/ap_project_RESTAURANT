import 'package:flutter/material.dart';
import 'package:models/models.dart';

class EditBottomSheet extends StatefulWidget {

  final Food food;
  final VoidCallback rebuildMenu;
  EditBottomSheet(this.food, this.rebuildMenu) : super();

  @override
  _EditBottomSheetState createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _description.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _name.text = widget.food.name;
    _price.text = widget.food.price.toString();
    _description.text = widget.food.description;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child:TextFormField(
                controller: _name,
                decoration: InputDecoration(
                    icon: Icon(Icons.drive_file_rename_outline)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child:TextFormField(
                controller: _price,
                decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child:TextFormField(
                controller: _description,
                decoration: InputDecoration(
                    icon: Icon(Icons.menu_book)
                ),
              ),
            ),
            Switch(
              value: widget.food.isAvailable,
              onChanged: (value){
                setState(() {
                  widget.food.isAvailable = value;
                });
              },
              activeColor: CommonColors.green,
              inactiveTrackColor: CommonColors.red,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildModelButton(Strings.get('edit-bottom-sheet-remove')!, CommonColors.red as Color, () async {
                  var response = await showDialog(
                    context: context,
                    builder: (context) => buildRemoveDialog(),
                    barrierDismissible: false,
                  );
                  if (response == false) return;
                  setState(() {
                    (Head.of(context).server.account as OwnerAccount).restaurant.menu!.removeFood(widget.food);
                    Navigator.of(context).pop();
                    widget.rebuildMenu();
                  });
                }),
                buildModelButton(Strings.get('edit-bottom-sheet-save')!, CommonColors.green as Color, () {
                  setState(() {
                    editFood(_name.text, _price.text, _description.text);
                    Navigator.of(context).pop();
                  });
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  void editFood(String newName , String newPrice , String newDesc)
  {
      widget.food.name = newName;
      widget.food.price = Price(int.parse(newPrice));
      widget.food.description = newDesc;
      widget.rebuildMenu();
  }

  buildRemoveDialog() {
    return AlertDialog(
      title: Text(Strings.get('food-remove-dialog-title')!),
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: CommonColors.black),
      content: SingleChildScrollView(
        child: Text(Strings.get('remove-food-dialog-message')!),
      ),
      contentTextStyle: TextStyle(fontSize: 15, color: CommonColors.black),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(Strings.get('food-remove-dialog-no')!),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(Strings.get('food-remove-dialog-yes')!),
        ),
      ],
    );
  }
}
