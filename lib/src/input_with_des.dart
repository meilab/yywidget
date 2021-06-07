import 'package:flutter/material.dart';
import 'package:yyutils/yyutils.dart';

class InputWithDes extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String title;
  final String hintText;
  final int maxLength;

  InputWithDes(
    this.title, {
    this.hintText = '',
    required this.controller,
    required this.focusNode,
    this.maxLength = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(MyMetrics.baseMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline4),
            SizedBox(height: MyMetrics.baseMargin),
            TextField(
              maxLength: maxLength,
              controller: controller,
              focusNode: focusNode,
              style: Theme.of(context).textTheme.headline4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: hintText,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
