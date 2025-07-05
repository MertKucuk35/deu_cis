import 'package:deu_cis/product/constants/color_consts.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  //to be edited
  AppTextStyles._();

  static const textFieldTextBlack = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textFieldTextColor);

  static const textFieldTextBoldGrey = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.grey);
  static const textFieldTextGrey = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.grey);
  static const textFieldTextLightGrey = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.greyLight);
  static const textFieldTextWhite = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.white);

  static const buttonText = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.white);

  static const titleTextWhite = TextStyle(
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto');

  static const titleTextBlack = TextStyle(
      color: AppColors.textFieldTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto');

  static const subTitleTextWhite = TextStyle(
      color: AppColors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto');

  static const subTitleTextBlack = TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto');
}
