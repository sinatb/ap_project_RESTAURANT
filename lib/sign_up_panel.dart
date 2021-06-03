import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'map_page.dart';
import 'main_panel.dart';

class SignUpPanel extends StatefulWidget {
  SignUpPanel() : super();

  @override
  _SignUpPanelState createState() => _SignUpPanelState();
}

class _SignUpPanelState extends State<SignUpPanel> {

  late Server server;
  String? _phoneNumber;
  String? _password;
  String? _name;
  String? _addressText;
  double? _latitude;
  double? _longitude;
  double? _radius;
  var _categories = <FoodCategory>{};
  bool _duplicateNumber = false;
  var _formKey = GlobalKey<FormState>();

  TextEditingController? _coordinatesController;
  TextEditingController? _radiusController;

  @override
  void initState() {
    _coordinatesController = TextEditingController();
    _radiusController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _coordinatesController?.dispose();
    _radiusController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    server = Head.of(context).server;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/login_background.jpg', package: 'models'), fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).cardColor,
            ),
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(Strings.get('sign-up-header')!, style: Theme.of(context).textTheme.headline1,),
                  const SizedBox(height: 10,),
                  if (_duplicateNumber)
                    buildDuplicateNumberError(),
                  buildLoginPhoneNumberField(server, (value) => _phoneNumber = value),
                  PasswordField(server, (value) => _password = value),
                  buildRestaurantNameField(),
                  buildAddressTextField(),
                  buildCoordinatesField(),
                  const SizedBox(height: 10,),
                  Text(Strings.get('settings-categories')!, style: Theme.of(context).textTheme.headline2,),
                  buildCategories(),
                  buildModelButton(Strings.get('sign-up-button')!, Theme.of(context).primaryColor, signUpPressed),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Strings.get('login-prompt')!),
                      TextButton(child: Text(Strings.get('login-button')!), onPressed: loginPressed,)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRestaurantNameField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.title),
        hintText: Strings.get('restaurant-name-hint'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Strings.get('restaurant-name-empty');
        }
      },
      onSaved: (value) => _name = value,
    );
  }

  Widget buildAddressTextField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.location_on),
        hintText: Strings.get('restaurant-address-text-hint'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Strings.get('address-text-empty');
        }
      },
      onSaved: (value) => _addressText = value,
    );
  }

  Widget buildCoordinatesField() {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: TextFormField(
            controller: _coordinatesController,
            decoration: InputDecoration(
              labelText: Strings.get('coordinates'),
              icon: Icon(Icons.map),
            ),
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Strings.get('coordinates-empty');
              }
            },
          ),
          flex: 3,
        ),
        Flexible(
          child: TextFormField(
            controller: _radiusController,
            decoration: InputDecoration(
              labelText: Strings.get('area-radius'),
            ),
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Strings.get('radius-empty');
              }
            },
          ),
          flex: 2,
        ),
        Flexible(
          child: TextButton(child: Text(Strings.get('set-radius-and-coordinates')!), onPressed: openMapPage,),
        )
      ],
    );
  }

  void openMapPage() async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MapPage())
    );
    if (result == null) return;
    setState(() {
      _radius = result['radius'];
      _latitude = result['lat'];
      _longitude = result['lng'];
      _coordinatesController!.text = '${_latitude?.toStringAsFixed(3)}, ${_longitude?.toStringAsFixed(3)}';
      _radiusController!.text = '${(_radius!/1000).toStringAsPrecision(2)} km';
    });
  }

  buildCategories() {
    return Wrap(
      spacing: 3,
      children: List.generate(FoodCategory.values.length, (index) {
        var category = FoodCategory.values[index];
        return ChoiceChip(
          label: Text(Strings.get(category.toString())!),
          selected: _categories.contains(category),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                _categories.add(category);
              } else {
                _categories.remove(category);
              }
            });
          },
        );
      }),
    );
  }

  buildDuplicateNumberError() {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).errorColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).errorColor),
      ),
      child: Text(Strings.get('duplicate-number-error')!, style: TextStyle(color: Theme.of(context).iconTheme.color),),
    );
  }

  void signUpPressed() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (!server.isPhoneNumberUnique(_phoneNumber!)) {
      setState(() {
        _duplicateNumber = true;
      });
      return;
    }
    var menu = FoodMenu(server);
    menu.serialize(server.serializer);
    var restaurant = Restaurant(
      name: _name!,
      menuID: menu.id,
      score: 0.0,
      address: Address(text: _addressText!, latitude: _latitude!, longitude: _longitude!),
      areaOfDispatch: _radius!,
      foodCategories: _categories,
    );
    server.signUpOwner(_phoneNumber!, _password!, restaurant, menu);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPanel()));
  }

  void loginPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPanel(isForUser: false, nextPageBuilder: (context) => MainPanel())));
  }
}
