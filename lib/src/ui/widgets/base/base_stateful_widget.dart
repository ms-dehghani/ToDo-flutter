import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  final GlobalKey<ScaffoldState> pageKey = GlobalKey<ScaffoldState>();

  void showSnack(String text) {
    if (text.isEmpty) return;
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   backgroundColor: const Color(0xff57595F),
    //   elevation: 32,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(res.Dimens.tenSize),
    //         topRight: Radius.circular(res.Dimens.tenSize),
    //       )),
    //   content: Text(
    //     text,
    //     softWrap: true,
    //     style: TextStyle(fontSize: res.Dimens.textSizeMid, color: res.Colors.white),
    //   ),
    // ));
  }
}
