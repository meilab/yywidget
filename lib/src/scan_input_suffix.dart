import 'package:flutter/material.dart';
import 'package:yyutils/yyutils.dart';

class ScanInputSuffix extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onPressed;
  final onClear;
  final String? scanImg;

  ScanInputSuffix(this.controller,
      {required this.onPressed, this.onClear, this.scanImg});
  @override
  Widget build(BuildContext context) {
    Widget suffixIcon = controller.text.length <= 0
        ? RawMaterialButton(
            constraints: BoxConstraints(),
            padding: const EdgeInsets.all(0.0),
            child: scanImg != null
                ? SmallIconImage(scanImg!)
                : Icon(Icons.scanner),
            onPressed: onPressed,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        : GestureDetector(
            child: Icon(Icons.clear),
            onTap: () {
              onClear?.call();
            });

    return suffixIcon;
  }
}
