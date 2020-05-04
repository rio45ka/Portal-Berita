import 'package:flutter/material.dart';

Widget bgGradient() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Colors.green,
          Colors.blue
        ],
      ),
    ),
  );
}

BoxShadow bgBoxShadowContainer() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    blurRadius: 1.0,
    spreadRadius: 0.5,
    offset: Offset(0.5, 0.5),
  );
}

BoxShadow bgBoxShadowContainer1() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    blurRadius: 1.0,
    spreadRadius: 1.0,
    offset: Offset(0.5, 0.5),
  );
}