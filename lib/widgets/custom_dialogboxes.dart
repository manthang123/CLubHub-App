import 'package:flutter/material.dart';

class AlertBox {
  final BuildContext context;
  final String? title;
  final IconData? icon;
  final String? messageText;
  final Color? titleTextColor;
  final Color? messageTextColor;
  final Color? button1Color;
  final Color? button1TextColor;
  final String? button1Text;
  final Color? button2Color;
  final Color? button2TextColor;
  final String? button2Text;
  void Function() button1OnClick;
  void Function()? button2OnClick;
  AlertBox({
    required this.context,
    this.title,
    this.messageText,
    this.titleTextColor,
    this.messageTextColor,
    this.button1Color,
    this.button1Text,
    this.button1TextColor,
    this.button2Color,
    this.button2Text,
    this.button2TextColor,
    this.icon,
    required this.button1OnClick,
    this.button2OnClick,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: <Widget>[
              Icon(
                icon != null ? icon : Icons.check_circle,
                color: titleTextColor ?? const Color(0xFF4CB051),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Flexible(
                child: Text(
                  title ?? "Your alert title",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: titleTextColor ?? const Color(0xFF4E4E4E)),
                ),
              )
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          children: <Widget>[
            Text(
              messageText ?? "Alert message here",
              style: TextStyle(color: messageTextColor),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 40)),
                      backgroundColor: MaterialStateProperty.all(
                        button1Color ?? const Color(0xFF4CB051),
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () => button1OnClick(),
                  child: Text(
                    button1Text ?? "Accept",
                    style: TextStyle(color: button1TextColor ?? Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                button2Text != null
                    ? TextButton(
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 40)),
                            backgroundColor: MaterialStateProperty.all(
                              button2Color ?? const Color(0xFF4CB051),
                            ),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () => button2OnClick!(),
                        child: Text(
                          button2Text ?? "Close",
                          style: TextStyle(
                              color: button2TextColor ?? Colors.white),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        );
      },
    );
  }
}
