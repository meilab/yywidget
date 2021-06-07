import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import './image_preview_item.dart';
import './pageTransformer.dart';

class ImagePreviewWidget extends StatefulWidget {
  final int initialPage;
  final List<File> images;
  final void Function(int) deleteCallback;
  ImagePreviewWidget(
      {required this.initialPage,
      required this.images,
      required this.deleteCallback});
  @override
  _ImagePreviewWidgetState createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  late PageController controller;

  @override
  void initState() {
    super.initState();

    controller =
        PageController(viewportFraction: 0.85, initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("图片预览"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                int idx = controller.page?.toInt() ?? 0;
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  widget.deleteCallback(idx);
                });
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // RouterManager.router.pop(context);
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: controller,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final item = widget.images[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);

                  return ImagePreviewItem(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
