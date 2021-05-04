import 'package:flutter/material.dart';
import 'package:models/models.dart';

Widget buildHeader(String title, Color textColor, double fontSize) {
  return SliverPadding(
    padding: EdgeInsets.all(10),
    sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(title, style: TextStyle(color: textColor, fontSize: fontSize,),),
            Divider(thickness: 2,),
          ],
        )
    ),
  );
}

Widget buildAvailableIcon(isAvailable) {
  if (isAvailable) {
    return Icon(Icons.check_circle, color: Colors.green,);
  }
  return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
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