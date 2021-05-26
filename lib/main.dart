import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'sign_up_panel.dart';

void main() {
  Server s = Server();
  FakeData f = FakeData(s);
  f.fill();
  runApp(Head(child: MyApp(), server: s));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: CommonColors.themeColorBlue ,
        scaffoldBackgroundColor: CommonColors.themeColorPlatinum,
        errorColor: CommonColors.red,
        buttonColor: CommonColors.green,
        iconTheme: IconThemeData(
          color: CommonColors.themeColorRed,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(color: CommonColors.themeColorRed ,fontWeight: FontWeight.bold, fontSize: 22),
          headline2: TextStyle(color: CommonColors.themeColorBlack , fontSize: 20)
        ),
      ),
      home: SignUpPanel(),
    );
  }
}