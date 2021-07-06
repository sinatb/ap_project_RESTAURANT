import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'reused_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFood extends StatefulWidget {

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {

  var _formKey = GlobalKey<FormState>();
  String _name = '';
  int _price = 0;
  String? _desc;
  FoodCategory _category = FoodCategory.values[0];
  ImagePicker picker = ImagePicker();
  var foodImage;
  double _padding = 10;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildNameField(_padding, (name) => _name = name!),
            buildDescriptionField(_padding, (desc) => _desc = desc),
            buildPriceField(_padding, (price) => _price = int.parse(price!)),
            buildCategoryDropdown(_padding),
            buildModelButton(Strings.get('edit-add-image')!, CommonColors.green!, (){getFoodImage();}),
            Center(
              child: buildModelButton('Create', CommonColors.green!, createFood),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryDropdown(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: DropdownButton<FoodCategory>(
        value: _category,
        items: FoodCategory.values.map((category) =>
            DropdownMenuItem<FoodCategory>(
              value: category,
              child: Text(Strings.get(category.toString())!),
            )
        ).toList(),
        onChanged: (category) => setState(() => _category = category!),
      ),
    );
  }

  void createFood() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    var server = Head.of(context).ownerServer;
    Food food = Food(category: _category, name: _name, price: Price(_price), server: server, image: foodImage, description: _desc);
    food.id = await server.serialize(food.runtimeType);
    Navigator.of(context).pop(food);
    ScaffoldMessenger.of(context).showSnackBar(
        showBar(Strings.get('add-food-successful')!, Duration(milliseconds: 2000))
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
}
