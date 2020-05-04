import 'package:flutter/material.dart';

void pageOpen(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

Color hexColor(String hex) =>
    new Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);