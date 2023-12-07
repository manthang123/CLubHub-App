// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';

import '../utils/ui_constant.dart';

class ShowCircularProgressIndicator extends StatelessWidget {
  ShowCircularProgressIndicator({
    super.key,
    this.height = 20,
    this.width = 20,
    this.strokeWidth = 3,
    this.indicatorColor = UiConstants.bgColorGrey,
  });

  double width, height, strokeWidth;
  Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: indicatorColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
