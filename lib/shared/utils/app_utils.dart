import 'package:flutter/material.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';

bool isEmail(String em) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(em);
}

bool isPassword(String em) {
  return em.length >= 8;
}

showSNackbar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: TextWidget.mediumText(
          text: message, fontSize: 14, color: AppColors.white)));
}
