import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'sign_up_panel.dart';

void main() {
  runApp(Head(child: MyApp(), server: OwnerServer()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Demo',
      theme: ThemeData.from(colorScheme: colorScheme1, textTheme: textTheme1)
      .copyWith(
        cardTheme: CardTheme(
          elevation: 2,
        ),
        cardColor: CommonColors.themeColorCard,
      ),
      home: SignUpPanel(),
    );
  }
}

const colorScheme1 = ColorScheme(
  primary: CommonColors.themeColorBlue,
  onPrimary: CommonColors.themeColorPlatinumLight,
  primaryVariant: CommonColors.themeColorBlueDark,
  error: CommonColors.themeColorRed,
  onError: CommonColors.themeColorPlatinumLight,
  secondary: CommonColors.themeColorYellow,
  onSecondary: CommonColors.themeColorPlatinumLight,
  secondaryVariant: CommonColors.themeColorYellowDark,
  background: CommonColors.themeColorPlatinumLight,
  brightness: Brightness.light,
  onBackground: CommonColors.themeColorBlack,
  surface: CommonColors.themeColorPlatinumLight,
  onSurface: CommonColors.themeColorBlack,
);

const textTheme1 = TextTheme(
  headline3: TextStyle(color: CommonColors.themeColorPlatinumLight, fontWeight: FontWeight.normal, fontSize: 22),
  headline4: TextStyle(color: CommonColors.themeColorPlatinumLight ,fontWeight: FontWeight.bold, fontSize: 22),
  headline1: TextStyle(color: CommonColors.themeColorBlack, fontWeight: FontWeight.normal, fontSize: 22),
  headline2: TextStyle(color: CommonColors.themeColorBlack, fontWeight: FontWeight.w600, fontSize: 22),
  headline5: TextStyle(color: CommonColors.themeColorBlack, fontWeight: FontWeight.w600, fontSize: 18),
  bodyText2: TextStyle(color: CommonColors.themeColorBlackTransparent, fontWeight: FontWeight.normal),
  bodyText1: TextStyle(color: CommonColors.themeColorBlack, fontWeight: FontWeight.normal),
);