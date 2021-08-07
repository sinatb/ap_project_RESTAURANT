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
  late List<FoodCategory> _restaurantCategories;
  String _name = '';
  int _price = 0;
  String? _desc;
  FoodCategory? _category;
  ImagePicker picker = ImagePicker();
  var foodImage;
  final double _padding = 12;

  @override
  Widget build(BuildContext context) {

    _restaurantCategories = Head.of(context).ownerServer.restaurant.foodCategories.toList(growable: false);
    _category ??= _restaurantCategories[0];

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildNameField(_padding, (name) => _name = name!),
            buildDescriptionField(_padding, (desc) => _desc = desc),
            buildPriceField(_padding, (price) => _price = int.parse(price!)),
            buildCategoryDropdown(_padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildModelButton(Strings.get('edit-add-image')!, Theme.of(context).buttonColor, (){getFoodImage();}),
                buildModelButton(Strings.get('create-food-button')!, Theme.of(context).accentColor, createFood),
              ],
            ),
            const SizedBox(height: 10,),
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
        items: _restaurantCategories.map((category) =>
            DropdownMenuItem<FoodCategory>(
              value: category,
              child: Text(Strings.get(category.toString())!),
            )
        ).toList(),
        onChanged: (category) => setState(() => _category = category!),
      ),
    );
  }

  void createFood() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    var server = Head.of(context).ownerServer;
    Food food = Food(category: _category!, name: _name, price: Price(_price), server: server, description: _desc);
    if (foodImage != null) {
      Head.of(context).depot[food] = foodImage;
    }
    Navigator.of(context).pop(food);
    ScaffoldMessenger.of(context).showSnackBar(
        showBar(Strings.get('add-food-successful')!, Duration(milliseconds: 2000))
    );
  }
  Future getFoodImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage!=null)
    {
      File image = File(pickedImage.path);
      foodImage = Image.file(image);
    }
  }
}
