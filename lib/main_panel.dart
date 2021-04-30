import 'package:flutter/material.dart';
import 'package:restaurant/order_page_widget.dart';
import 'edit_menu.dart';
import 'package:models/models.dart';

class MainPanel extends StatefulWidget {
  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  var _currentIndex = 1;

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: Strings.get('bottom-nav-label-stats'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood_outlined),
          label: Strings.get('bottom-nav-label-edit'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delivery_dining),
          label: Strings.get('bottom-nav-label-order'),
        ),
      ],
      currentIndex:_currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  var _pages = <Widget>[
    Center(child: Text('To Be Implemented'),),
    EditMenuPanel(),
    OrderPagePanel(),
  ];

}