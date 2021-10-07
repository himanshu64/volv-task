import 'package:flutter/material.dart';

class CustomFullScreenDialog {
  static void showAlertDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (ctx) => WillPopScope(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      // barrierColor: const Color.withOpacity(.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
