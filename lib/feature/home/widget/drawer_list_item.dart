import 'package:deu_cis/feature/home/subview/draweritems/qr_scan/qr_view.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final VoidCallback? function;
  final Widget icon;
  final String title;

  const DrawerListItem({
    super.key,
    required this.icon,
    required this.title,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      leading: icon,
      title: Text(title),
    );
  }
}
