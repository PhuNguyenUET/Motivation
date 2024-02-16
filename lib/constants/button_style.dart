import 'package:flutter/material.dart';

var buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(12.0)),
  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0))
  ),
  side: MaterialStateProperty.all<BorderSide>(
    BorderSide(width: 1.0, color: Colors.grey[700]!),
  ),
);