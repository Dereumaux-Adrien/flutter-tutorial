library tutorial;

import 'package:flutter/material.dart';
import 'package:app_tutorial/src/models/tutorial_item.dart';
import 'package:app_tutorial/src/painter/painter.dart';

class Tutorial {
  static showTutorial(
    BuildContext context,
    List<TutorialItem> children,
  ) async {
    int count = 0;
    var size = MediaQuery.of(context).size;
    OverlayState overlayState = Overlay.of(context)!;
    List<OverlayEntry> entries = [];
    children.forEach(
      (element) async {
        var offset = _capturePositionWidget(element.globalKey!);
        var sizeWidget = _getSizeWidget(element.globalKey!);
        entries.add(
          OverlayEntry(
            builder: (context) {
              return GestureDetector(
                onTap: element.touchScreen == true
                    ? () {
                        entries[count].remove();
                        count++;
                        if (count != entries.length) {
                          overlayState.insert(entries[count]);
                        }
                      }
                    : () {},
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      CustomPaint(
                        size: size,
                        painter: HolePainter(
                          shapeFocus: element.shapeFocus,
                          dx: offset.dx + (sizeWidget.width / 2),
                          dy: offset.dy + (sizeWidget.height / 2),
                          width: sizeWidget.width,
                          height: sizeWidget.height,
                          color: element.backgroundColor,
                          borderRadius: element.borderRadius,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: element.children,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  child: element.widgetNext ??
                                      Text(
                                        "NEXT",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                  onTap: () {
                                    entries[count].remove();
                                    count++;
                                    if (count != entries.length) {
                                      overlayState.insert(entries[count]);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
    overlayState.insert(entries[0]);
  }

  static Offset _capturePositionWidget(GlobalKey key) {
    RenderBox renderPosition =
        key.currentContext!.findRenderObject() as RenderBox;

    return renderPosition.localToGlobal(Offset.zero);
  }

  static Size _getSizeWidget(GlobalKey key) {
    RenderBox renderSize = key.currentContext!.findRenderObject() as RenderBox;
    return renderSize.size;
  }
}
