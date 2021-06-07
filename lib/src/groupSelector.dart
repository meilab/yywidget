import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yyutils/yyutils.dart';

class GroupSelector extends StatelessWidget {
  final List<dynamic> types;
  final String selectedType;
  final onPressed;
  final getImage;
  final String? selectedCheckImg;

  GroupSelector(this.types, this.onPressed,
      {required this.selectedType, this.getImage, this.selectedCheckImg});

  @override
  Widget build(BuildContext context) {
    Widget _renderLabel(dynamic item, String type) => Container(
          width: 70,
          height: getImage != null ? 64 : 38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getImage != null ? getImage.call(type) : Container(),
              // Backend give us different key name
              Text(item?.name, style: Theme.of(context).textTheme.headline4),
            ],
          ),
        );

    Widget _renderFillerType(dynamic item) {
      final String type = item?.code ?? "";

      final Color borderColor = type == selectedType
          ? Color(primaryColor)
          : Color(inactiveBorderColor);
      // final Color selectedColor = Color(activeBgColor);
      final Color selectedColor = Colors.white;

      return Stack(children: [
        ChoiceChip(
          key: ValueKey<String>(type),
          backgroundColor: Colors.white,
          label: _renderLabel(item, type),
          selected: selectedType == type,
          selectedColor: selectedColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, color: borderColor),
              borderRadius:
                  BorderRadius.all(Radius.circular(MyMetrics.buttonRadius))),
          onSelected: (bool value) {
            if (value == true) {
              onPressed(type);
            }
          },
        ),
        (selectedType == type && selectedCheckImg != null)
            ? Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  selectedCheckImg!,
                  width: 20,
                  height: 20,
                ),
              )
            : Container()
      ]);
    }

    return Column(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(bottom: MyMetrics.baseMargin),
        width: double.infinity,
        // padding: const EdgeInsets.only(bottom: MyMetrics.baseMargin),
        child: Text('选择类型', style: Theme.of(context).textTheme.headline4),
      ),
      Container(
        width: double.infinity,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: types.map<Widget>(_renderFillerType).toList()),
      )
    ]);
  }
}
