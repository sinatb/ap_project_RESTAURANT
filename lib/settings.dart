import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:models/models.dart';
import 'comments_panel.dart';
import 'map_page.dart';

class SettingsPanel extends StatefulWidget {

  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {

  late Restaurant restaurant;

  static const _smallHeading = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const _regular = TextStyle(fontSize: 18);

  final imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var owner = Head.of(context).server.account! as OwnerAccount;
    restaurant = owner.restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.get('settings-appbar-title')! , style: Theme.of(context).textTheme.headline1,),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAccountTile(owner),
            buildRestaurantTile(),
            buildCategoriesTile(),
            buildAddressTile(),
            buildCommentsTile(),
          ],
        ),
      ),
    );
  }

  Widget buildAccountTile(OwnerAccount owner) {
    return ExpansionTile(
      title: Text(Strings.get('account')!),
      leading: Icon(Icons.person),
      maintainState: true,
      children: [
        buildTextField(Strings.get('phone-number')!, Strings.censorPhoneNumber(owner.phoneNumber)),
      ],
    );
  }

  Widget buildRestaurantTile() {

    var padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0);

    return ExpansionTile(
      title: Text(Strings.get('restaurant-info-label')!),
      leading: Icon(Icons.restaurant),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Wrap(
            spacing: 10,
            children: [
              Text(Strings.get('restaurant-name-label')!, style: _smallHeading),
              Text(restaurant.name, style: _regular,),
            ],
          ),
        ),
        Padding(
          padding: padding,
          child: Wrap(
            spacing: 10,
            children: [
              Text(Strings.get('restaurant-score-label')!, style: _smallHeading,),
              buildScoreFill(restaurant.score),
            ],
          ),
        ),
        Padding(
          padding: padding,
          child: Text(Strings.get('logo-label')!, style: _smallHeading,),
        ),
        SizedBox(height: 10,),
        Center(
          child: Container(
            child: restaurant.logo,
            width: MediaQuery.of(context).size.width/2,
          ),
        ),
        SizedBox(height: 10,),
        Center(child: buildModelButton(Strings.get('edit-add-image')!, Theme.of(context).primaryColor, editLogo))
      ],
    );
  }

  void editLogo() async {
    var newLogo = await imagePicker.getImage(source: ImageSource.gallery);
    if (newLogo == null) return;
    restaurant.logo = Image.file(File(newLogo.path));
    setState(() {

    });
  }

  Widget buildCategoriesTile() {
    return ExpansionTile(
      title: Text(Strings.get('settings-categories')!),
      leading: Icon(Icons.fastfood_outlined),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            spacing: 10,
            children: List<Widget>.generate(FoodCategory.values.length, (index) {
              var category = FoodCategory.values[index];
              return ChoiceChip(
                label: Text(Strings.get(category.toString())!),
                selected: restaurant.foodCategories.contains(category),
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      restaurant.foodCategories.add(category);
                    } else {
                      restaurant.foodCategories.remove(category);
                    }
                  });
                },
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildCommentsTile() {
    return ExpansionTile(
      key: GlobalKey(),
      title: Text(Strings.get('comment-button')!),
      leading: Icon(Icons.comment),
      onExpansionChanged: (isOpen) {
        if (isOpen) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CommentsPanel())
          );
          setState(() {});
        }
      },
    );
  }

  Widget buildAddressTile() {
    return ExpansionTile(
      title: Text(Strings.get('address-tile')!),
      leading: Icon(Icons.location_on_outlined),
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: Strings.get('address-text-title')!,
              ),
              initialValue: restaurant.address.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.get('empty-address-text');
                }
              },
              onSaved: (value) => restaurant.address.text = value!,
            ),
          ),
        ),
        buildTextField(Strings.get('coordinates')!, '${restaurant.address.latitude.toStringAsFixed(5)}, ${restaurant.address.longitude.toStringAsFixed(5)}'),
        buildTextField(Strings.get('area-radius')!, '${(restaurant.areaOfDispatch/1000).toStringAsPrecision(2)} km'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildModelButton(Strings.get('edit-address')!, Theme.of(context).primaryColor, () => openMapPage()),
            buildModelButton(Strings.get('save-address')!, Theme.of(context).buttonColor, () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {

                });
              }
            }),
          ],
        ),
      ],
    );
  }

  void openMapPage() async {
    var coordinates = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MapPage()),
    );
    if (coordinates == null) return;
    restaurant.address.latitude = coordinates['lat'];
    restaurant.address.longitude = coordinates['lng'];
    restaurant.areaOfDispatch = coordinates['radius'];
    setState(() {

    });
  }

}
