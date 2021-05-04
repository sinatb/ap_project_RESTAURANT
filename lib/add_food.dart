import 'package:flutter/material.dart';
import 'package:models/models.dart';
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
  @override

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildPriceField(),
            buildCategoryDropdown(),
            Center(
              child: buildModelButton('Create', CommonColors.green!, createFood),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCategoryDropdown() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DropdownButton<FoodCategory>(
        value: _category,
        items: FoodCategory.values.map((category) =>
            DropdownMenuItem<FoodCategory>(
              value: category,
              child: Text(Strings.get(category.toString())!),
            )
        ).toList(),
        onChanged: (category) {
          setState(() {
            _category = category!;
          });
          },
      ),
    );
  }

  Padding buildPriceField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (String? number) {
          if (number == null || number.isEmpty) {
            return Strings.get('add-food-empty-price-error');
          }
          var parsed = int.tryParse(number);
          if (parsed == null || parsed <= 0) {
            return Strings.get('add-food-invalid-price-error');
          }
          },
        onSaved: (value) {
          _price = int.parse(value!);
          },
        decoration: InputDecoration(
          hintText: Strings.get('add-bottom-sheet-food-price')!,
          icon: Icon(Icons.attach_money_rounded),
        ),
      ),
    );
  }

  Padding buildDescriptionField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLength: 400,
        maxLines: 3,
        onSaved: (desc) {
          _desc = desc;
          },
        decoration: InputDecoration(
          hintText: Strings.get('add-bottom-sheet-food-description')!,
          icon: Icon(Icons.text_snippet_outlined),
          hintMaxLines: 3,
        ),
      ),
    );
  }

  Padding buildNameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: (name) {
          if (name == null || name.isEmpty) {
            return Strings.get('add-food-empty-name-error');
          }
          },
        onSaved: (name) {
          _name = name!;
          },
        decoration: InputDecoration(
          hintText: Strings.get('add-bottom-sheet-food-name')!,
          icon: Icon(Icons.fastfood_sharp),
        ),
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
