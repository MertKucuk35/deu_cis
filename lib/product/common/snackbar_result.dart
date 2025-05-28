// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/index.dart';

class SnackBarResponse {
  BuildContext context;
  SnackBarResponse({
    required this.context,
  });

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showResponse(
      bool succes, String content) {
    if (succes) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.possitiveResult, content: Text(content)));
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.negativeResult, content: Text(content)));
    }
  }
}
