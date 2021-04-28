import 'package:flutter/material.dart';
import 'package:restaurant/main_page.dart';
import 'package:models/models.dart';
void main() {
  Server s = Server(DataBase.empty());
  FakeData f = FakeData(s.dataBase!, s);
  f.fill();
  s.login('09123123123', 'owner123');
  runApp(Head(child: MyApp(), server: s));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: main_page(),
    );
  }
}