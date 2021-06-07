import 'dart:io';

import 'package:flutter/material.dart';
import './pageTransformer.dart';

class ImagePreviewItem extends StatelessWidget {
  ImagePreviewItem({
    required this.item,
    required this.pageVisibility,
  });

  final File item;
  final PageVisibility pageVisibility;

  @override
  Widget build(BuildContext context) {
    var image = Image.file(
      item,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: image,
      ),
    );
  }
}
