import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog popUp({
  required BuildContext context,
  required String title,
  required String body,
  required String dialogType,
  bool isHeader = true
}) 
{
  return AwesomeDialog(
    context: context,
    dialogType: chooseDialogType(dialogType),
    title: title,
    body: Column(
      children: [
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(fontSize: 15)),
        const SizedBox(height: 20),
      ],
    ),
  )..show();
}

DialogType chooseDialogType(String type) {
  switch (type) {
    case 'warning': return DialogType.warning;
    case 'error': return DialogType.error;
    case 'success': return DialogType.success;
    case 'info': return DialogType.info;
    
    default: return DialogType.info;
  }
}