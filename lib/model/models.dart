import 'package:flutter/material.dart';

class AppFeatureItemModel {
  final Color color;
  final String image;
  final String text1;
  final String text2;

  AppFeatureItemModel(this.color, this.image, this.text1, this.text2);
}

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView({required String title, required IconData icon, required IconData activeIcon})
      : item = new BottomNavigationBarItem(
            icon: Icon(icon), activeIcon: Icon(activeIcon), label: title, backgroundColor: Colors.white);
}
