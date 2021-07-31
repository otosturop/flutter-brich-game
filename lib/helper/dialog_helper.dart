import 'package:flutter/material.dart';
import 'package:tetris/componets/custom_dialog.dart';

class DialogHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => CustomDialog());
}
