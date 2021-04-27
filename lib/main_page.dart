import 'package:flutter/material.dart';
import 'package:restaurant/colors.dart';
import 'package:restaurant/menu_page_widget.dart';
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
      backgroundColor: common_colors.blue,
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: "messages",
        backgroundColor: common_colors.green
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.fastfood_outlined),
      label: "orders",
      backgroundColor: common_colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "settings",
      backgroundColor: common_colors.cyan,
    )
  ];




  @override
  Widget build(BuildContext context) {
    var page_widgets=[
      menu_page_widget.menu_page_grid_view(context),
    ];



    return Scaffold(
      body: Center(
        child: page_widgets.elementAt(bottom_nav_current_index),
      ),
      bottomNavigationBar: bottom_nav_creater(),
    );
  }

  //main bottom nav widget
  Widget bottom_nav_creater()
  {
    return BottomNavigationBar(
      items: bottom_nav_main_items,
      currentIndex:bottom_nav_current_index,
      selectedItemColor: common_colors.black,
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