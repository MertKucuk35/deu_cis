import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final Icon? icon;
  final Widget child;

  TabItem({required this.title, this.icon, required this.child});
}
