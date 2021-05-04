import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'reused_ui.dart';

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

  void createFood() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    var server = Head.of(context).server;
    Food food = Food(category: _category, name: _name, price: Price(_price), server: server, description: _desc);
    food.serialize(server.serializer);
    Navigator.of(context).pop(food);
  }

}
