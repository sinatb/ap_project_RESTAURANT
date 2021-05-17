import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'reused_ui.dart';

class EditBottomSheet extends StatefulWidget {

  final Food food;
  final VoidCallback rebuildMenu;
  EditBottomSheet(this.food, this.rebuildMenu) : super();

  @override
  _EditBottomSheetState createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {

  var _formKey = GlobalKey<FormState>();
  double _padding = 20;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildNameField(_padding, (name) => widget.food.name = name!, widget.food.name),
            buildDescriptionField(_padding, (desc) => widget.food.description = desc ?? '', widget.food.description),
            buildPriceField(_padding, (price) => widget.food.price = Price(int.parse(price!)), widget.food.price.toString()),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                      showBar(Strings.get('delete-food-successful')!, Duration(milliseconds: 2000))
                  );
                }),
                buildModelButton(Strings.get('edit-bottom-sheet-save')!, CommonColors.green as Color, () {
                  if (_formKey.currentState!.validate() == false) return;
                  _formKey.currentState!.save();
                  setState(() {
                    Navigator.of(context).pop(true);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      showBar(Strings.get('edit-food-edit-successful')!, Duration(milliseconds: 2000))
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
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
