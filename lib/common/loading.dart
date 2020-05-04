import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  const Loading({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 20,
        ),
        Text(message)
      ],
    ));
  }
}
