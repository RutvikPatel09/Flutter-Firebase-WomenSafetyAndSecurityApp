import 'package:flutter/material.dart';

import '../main.dart';

class CategoryIcon extends StatelessWidget {
  Color color;
  String iconName;

  CategoryIcon({required this.color, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Container(
      color: this.color,
      padding: EdgeInsets.all(10),
      child: IconFont(color: Colors.white, iconName: this.iconName, size: 30),
    ));
  }
}
