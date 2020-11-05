import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static Color appPrimaryColor = Color(0xFF7966FF);
  static Color appBackground = Color(0xFFF1EEFC);
  static Color appCanvasColor = Color(0xFF9EB7FF);
  static Color whiteColor = Colors.white;

  static InputDecoration input = InputDecoration(
    fillColor: Colors.white,
    focusColor: Colors.grey[900],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    border: OutlineInputBorder(
      gapPadding: 1.0,
      borderSide: BorderSide(color: Colors.grey[600], width: 1.0),
    ),
    hintStyle: TextStyle(
      color: Colors.grey[600],
    ),
  );
}

Widget mediumVerticalSpacer() => SizedBox(height: 30);

void moveToReplace(BuildContext context, whereTo) {
  Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => whereTo));
}

void moveTo(BuildContext context, whereTo) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => whereTo));
}
