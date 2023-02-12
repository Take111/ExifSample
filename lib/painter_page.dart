import 'package:exif_sample/show_image_picker.dart';
import 'package:flutter_painter/flutter_painter_extensions.dart';
import 'package:flutter_painter/flutter_painter_pure.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

// ① FloatingButtonからアルバムを選択
// ② Rectangleのボタンを選択
// ③ SwitchからFillを選択

class PainterPage extends StatefulWidget {
  const PainterPage({super.key});

  @override
  State<PainterPage> createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage> {
  late PainterController controller;
  ui.Image? backgroundImage;

  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void initState() {
    super.initState();

    controller = PainterController(
      settings: const PainterSettings(
        freeStyle: FreeStyleSettings(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: FlutterPainter(
                controller: controller,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('手書き'),
                Switch(
                  value: controller.freeStyleMode == FreeStyleMode.draw,
                  onChanged: ((value) {
                    setState(() {
                      controller.freeStyleMode =
                          value ? FreeStyleMode.draw : FreeStyleMode.none;
                    });
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.shapeFactory = RectangleFactory();
                  },
                  child: const Text('Rectangle'),
                ),
                Text('Fill'),
                Switch(
                  value: (controller.shapePaint ?? shapePaint).style ==
                      PaintingStyle.fill,
                  onChanged: ((value) {
                    setState(() {
                      controller.shapePaint =
                          (controller.shapePaint ?? shapePaint).copyWith(
                        style:
                            value ? PaintingStyle.fill : PaintingStyle.stroke,
                      );
                    });
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          final imageFile = await showPhotoAndPickImage(context);

          if (imageFile != null) {
            // Note: Image
            final image = await Image.file(imageFile).image.image;
            setState(() {
              backgroundImage = image;
              controller.background = image.backgroundDrawable;
            });
          }
        }),
        child: const Icon(
          Icons.photo,
        ),
      ),
    );
  }
}
