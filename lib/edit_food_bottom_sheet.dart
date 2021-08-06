import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  final picker = ImagePicker();
  var foodImage;
  bool? isAvailable;
  @override
  Widget build(BuildContext context) {

    if (isAvailable == null) {
      isAvailable = widget.food.isAvailable;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildNameField(_padding, (name) => widget.food.name = name!, widget.food.name),
            buildDescriptionField(_padding, (desc) => widget.food.description = desc ?? '', widget.food.description),
            buildPriceField(_padding, (price) => widget.food.price = Price(int.parse(price!)), widget.food.price.toString()),
            Switch(
              value: isAvailable ?? widget.food.isAvailable,
              onChanged: (value) {
                setState(() {
                  isAvailable = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildModelButton(Strings.get('edit-bottom-sheet-remove')!, Theme.of(context).errorColor, () async {
                  var response = await showDialog(
                    context: context,
                    builder: (context) => buildRemoveDialog(),
                    barrierDismissible: false,
                  );
                  if (response == false) return;
                  setState(() {
                    // might be problem
                    Head.of(context).ownerServer.restaurant.menu!.removeFood(widget.food);
                    Navigator.of(context).pop();
                    widget.rebuildMenu();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      showBar(Strings.get('delete-food-successful')!, Duration(milliseconds: 2000))
                  );
                }),
                buildModelButton(Strings.get('edit-add-image')!, Theme.of(context).buttonColor, (){getFoodImage();}),
                buildModelButton(Strings.get('edit-bottom-sheet-save')!, Theme.of(context).primaryColor, () async {
                  if (_formKey.currentState!.validate() == false) return;
                  if (foodImage != null) {
                    widget.food.image = foodImage;
                  }
                  _formKey.currentState!.save();
                  widget.food.isAvailable = isAvailable!;
                  await Head.of(context).ownerServer.edit(widget.food);
                  setState(() {
                    Navigator.of(context).pop(true);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      showBar(Strings.get('edit-food-edit-successful')!, Duration(milliseconds: 2000))
                  );
                })
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  Future getFoodImage() async{
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage!=null)
    {
      File image = File(pickedImage.path);
      foodImage = Image.file(image);
    }
  }
  buildRemoveDialog() {
    var black = Theme.of(context).colorScheme.onBackground;
    return AlertDialog(
      title: Text(Strings.get('food-remove-dialog-title')!),
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: black),
      content: SingleChildScrollView(
        child: Text(Strings.get('remove-food-dialog-message')!),
      ),
      contentTextStyle: TextStyle(fontSize: 15, color: black),
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
