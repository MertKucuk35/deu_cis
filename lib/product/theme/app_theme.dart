import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.drawerColor),
          backgroundColor: AppColors.themeColor));

  static ThemeData darkTheme = ThemeData.dark().copyWith(useMaterial3: true);
}
