import 'package:flutter/material.dart';
import 'package:restaurant/EditMenu.dart';
import 'package:models/models.dart';

class main_page extends StatefulWidget {
  @override
  _main_pageState createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  int bottom_nav_current_index=0;
  //bottom nav items
  var bottom_nav_main_items =  [
    BottomNavigationBarItem(
      icon: Icon(Icons.menu_book_outlined),
      label: "Edit menu",
      backgroundColor: CommonColors.blue,
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: "messages",
        backgroundColor: CommonColors.green
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.fastfood_outlined),
      label: "orders",
      backgroundColor: CommonColors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "settings",
      backgroundColor: CommonColors.cyan,
    )
  ];




  @override
  Widget build(BuildContext context) {
    var page_widgets=[
      EditMenu(),
    ];



    return Scaffold(
      body: page_widgets[bottom_nav_current_index],
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  //main bottom nav widget
  Widget buildBottomNavigation()
  {
    return BottomNavigationBar(
      items: bottom_nav_main_items,
      currentIndex:bottom_nav_current_index,
      selectedItemColor: CommonColors.black,
      onTap: change_nav_current_index,
    );
  }
  void change_nav_current_index(int index)
  {
    setState(() {
      bottom_nav_current_index = index;
    });
  }
//end bottom nav

}