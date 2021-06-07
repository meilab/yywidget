import 'package:flutter/material.dart';
import 'package:yyutils/yyutils.dart';

class FlexButton extends StatelessWidget {
  final String text;

  final Color color;

  final Color textColor;

  final VoidCallback onPress;

  final int maxLines;
  final double horizontalMargin;
  final double verticalMargin;
  final bool loading;

  final MainAxisAlignment mainAxisAlignment;

  FlexButton(
      {Key? key,
      required this.text,
      this.color = const Color(primaryColor),
      this.textColor = Colors.white,
      required this.onPress,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.horizontalMargin = MyMetrics.baseMargin,
      this.verticalMargin = MyMetrics.doubleBaseMargin,
      this.loading = false,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: 64,
            margin: EdgeInsets.symmetric(
                vertical: MyMetrics.doubleBaseMargin,
                horizontal: horizontalMargin),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: color),
                child: new Flex(
                  mainAxisAlignment: mainAxisAlignment,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    new Text(text,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: textColor),
                        maxLines: maxLines,
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
                onPressed: () {
                  this.onPress.call();
                }),
          );
  }
}
