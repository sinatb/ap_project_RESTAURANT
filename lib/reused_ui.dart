import 'package:flutter/material.dart';
import 'package:models/models.dart';

Widget buildAvailableIcon(isAvailable) {
  if (isAvailable) {
    return Icon(Icons.check_circle, color: CommonColors.themeColorGreen,);
  }
  return Icon(Icons.highlight_remove_rounded, color: CommonColors.themeColorRed,);
}

Widget buildPriceField(double padding, void Function(String?) onSaved, [String? initialValue]) {
  return Padding(
    padding: EdgeInsets.all(padding),
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
      onSaved: onSaved,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: Strings.get('add-bottom-sheet-food-price')!,
        icon: Icon(Icons.attach_money_rounded),
      ),
    ),
  );
}

Widget buildDescriptionField(double padding, void Function(String?) onSaved, [String? initialValue]) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: TextFormField(
      keyboardType: TextInputType.multiline,
      maxLength: 400,
      maxLines: 3,
      onSaved: onSaved,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: Strings.get('add-bottom-sheet-food-description')!,
        icon: Icon(Icons.text_snippet_outlined),
        hintMaxLines: 3,
      ),
    ),
  );
}

Widget buildNameField(double padding, void Function(String?) onSaved, [String? initialValue]) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: TextFormField(
      validator: (name) {
        if (name == null || name.isEmpty) {
          return Strings.get('add-food-empty-name-error');
        }
      },
      onSaved: onSaved,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: Strings.get('add-bottom-sheet-food-name')!,
        icon: Icon(Icons.fastfood_sharp),
      ),
    ),
  );
}