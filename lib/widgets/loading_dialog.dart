import 'package:clubhub/widgets/circular_progressIndicator.dart';
import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context, bool show) {
  AlertDialog alert = AlertDialog(
    content: SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          ShowCircularProgressIndicator(height: 30, width: 30),
          const SizedBox(height: 20),
          const Text(
            "Validating...",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
  show
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        )
      : Navigator.of(context).pop();
}
