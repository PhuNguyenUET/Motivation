import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class Constants {
  static var textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.all(15.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
      borderRadius: BorderRadius.circular(50),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      borderRadius: BorderRadius.circular(50),
    ),
    errorBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.circular(50),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.circular(50),
    ),
  );
}