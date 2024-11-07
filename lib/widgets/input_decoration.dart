import 'package:flutter/material.dart';

InputDecoration inputDecoration(String label, String hint, IconData icon) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF14919B), width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF14919B), width: 2.0),
    ),
    hintText: hint,
    labelText: label,
    labelStyle: const TextStyle(color: Colors.grey),
    prefixIcon: Icon(icon, color: const Color(0xFF14919B)),
  );
}
