import 'package:flutter/material.dart';
import 'main_panel.dart';
import 'package:models/models.dart';
void main() {
  Server s = Server();
  FakeData f = FakeData(s);
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
      home: MainPanel(),
    );
  }
}