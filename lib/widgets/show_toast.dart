import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/ui_constant.dart';

showToast(
    {required FToast fToast,
    required String message,
    IconData? icon,
    required Color colorVal}) {
  return fToast.showToast(
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: colorVal,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: UiConstants.whiteColor,
                  )
                : Text(""),
            const SizedBox(
              width: 12.0,
            ),
            SizedBox(
              width: 200,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: UiConstants.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}
