import 'package:flutter/material.dart';

Widget buildHeader(String title, Color textColor, double fontSize) {
  return SliverPadding(
    padding: EdgeInsets.all(10),
    sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(title, style: TextStyle(color: textColor, fontSize: fontSize,),),
            Divider(thickness: 2,),
          ],
        )
    ),
  );
}

Widget buildAvailableIcon(isAvailable) {
  if (isAvailable) {
    return Icon(Icons.check_circle, color: Colors.green,);
  }
  return Icon(Icons.highlight_remove_rounded, color: Colors.red,);
}