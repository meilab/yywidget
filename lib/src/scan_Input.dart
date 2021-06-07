import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yyutils/yyutils.dart';

class ScanInput extends StatelessWidget {
  @required
  final String image;
  @required
  final Widget suffixIcon;
  @required
  final String hintText;
  @required
  final TextEditingController controller;
  @required
  final FocusNode focusNode;
  @required
  final onComplete;
  final readOnly;
  final Color fillColor;
  final int maxLength;
  final String? Function(String?)? validator;

  ScanInput(
      {required this.image,
      required this.suffixIcon,
      required this.hintText,
      required this.controller,
      required this.focusNode,
      this.onComplete,
      this.readOnly = false,
      this.fillColor = Colors.white,
      this.maxLength = 99,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    final keyboardType =
        Platform.isAndroid ? TextInputType.number : TextInputType.text;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        style: Theme.of(context).textTheme.headline4,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ConstrainedBox(
              child: Row(
                children: <Widget>[
                  SmallIconImage(image),
                ],
              ),
              constraints: BoxConstraints(maxWidth: 40),
            ),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          hintText: hintText,
        ),
        textAlign: TextAlign.right,
        validator: validator,
        onFieldSubmitted: (value) {
          onComplete?.call(controller.text);
        },
      ),
    );
  }
}
