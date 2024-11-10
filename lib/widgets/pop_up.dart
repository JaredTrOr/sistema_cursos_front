import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog popUp({
  required BuildContext context,
  required String title,
  required Widget body,
  bool isHeader = true
}) 
{
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    title: title,
    body: body,
  )..show();
}