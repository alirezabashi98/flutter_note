import 'package:flutter/material.dart';

openPage(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
