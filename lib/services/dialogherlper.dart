import 'package:flutter/material.dart';
import 'exitconfirm.dart';

class DialogHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => ExitConfirmation());
}