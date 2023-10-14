import 'package:flutter/material.dart';

Future<dynamic> navigateToPage(BuildContext context, Widget page) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    ),
  );
}
