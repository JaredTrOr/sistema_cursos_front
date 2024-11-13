import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog popUpConfirmation({
  required BuildContext context,
  required String title,
  required Widget body,
  required VoidCallback onAccept,
  bool isHeader = true
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    title: title,
    body: body,
    btnOkOnPress: onAccept,
    btnCancelOnPress: () {},
  )..show();
}