import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'food_predicate.dart';

class SearchBottomSheet extends StatelessWidget {

  static final _formKey = GlobalKey<FormState>();
  static final _predicateObject = FoodPredicate();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.get('menu-search-options-title')!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: Strings.get('search-name-hint'),
                    icon: Icon(Icons.drive_file_rename_outline)
                  ),
                  onSaved: (value) {
                    _predicateObject.name = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LimitedBox(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: Strings.get('price-from'),
                          icon: Icon(Icons.attach_money_rounded),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _predicateObject.lowerPrice = value;
                        },
                        validator: priceValidator
                      ),
                      maxWidth: deviceWidth/2 - 50,
                    ),
                    LimitedBox(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: Strings.get('price-to')
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _predicateObject.upperPrice = value;
                        },
                        validator: priceValidator
                      ),
                      maxWidth: deviceWidth/2 - 50,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Strings.get('search-availability')!),
                  MyCheckBox(_predicateObject)
                ],
              ),
              Center(
                child: buildModelButton(Strings.get('search')!, Theme.of(context).buttonColor, () {
                  if (_formKey.currentState!.validate() == false) return;
                  _formKey.currentState!.save();
                  Navigator.of(context).pop(_predicateObject.generate());
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    var parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return Strings.get('add-food-invalid-price-error');
    return null;
  }
}

class MyCheckBox extends StatefulWidget {

  final FoodPredicate predicateObject;

  MyCheckBox(this.predicateObject);

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(value: widget.predicateObject.availability,
        onChanged: (newValue) => setState(() {
          widget.predicateObject.availability = newValue ?? widget.predicateObject.availability;
        }),
        activeColor: Theme.of(context).primaryColor,
    );
  }
}




