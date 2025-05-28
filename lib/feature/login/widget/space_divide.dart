import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpaceDivide extends StatelessWidget {
  SpaceDivide({super.key, required this.height});
  double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
