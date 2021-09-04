library tutorial;

import 'package:app_tutorial/src/components/tutorial_layout.dart';
import 'package:flutter/material.dart';
import 'package:app_tutorial/src/models/tutorial_item.dart';
import 'package:app_tutorial/src/painter/painter.dart';

class Tutorial {
  static showTutorial(
    BuildContext context,
    List<TutorialItem> children,
  ) async {
    int count = 0;
    var sizeScreen = MediaQuery.of(context).size;
    OverlayState overlayState = Overlay.of(context)!;
    List<OverlayEntry> entries = [];
    children.forEach(
      (element) async {
        var offsetWidget = _capturePositionWidget(element.globalKey!);
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
                        size: sizeScreen,
                        painter: HolePainter(
                          shapeFocus: element.shapeFocus,
                          dx: offsetWidget.dx +
                              (sizeWidget.width / 2) -
                              element.extraPadding.left,
                          dy: offsetWidget.dy +
                              (sizeWidget.height / 2) -
                              element.extraPadding.top,
                          width: sizeWidget.width +
                              element.extraPadding.left +
                              element.extraPadding.right,
                          height: sizeWidget.height +
                              element.extraPadding.top +
                              element.extraPadding.bottom,
                          color: element.backgroundColor,
                          borderRadius: element.borderRadius,
                        ),
                      ),
                      TutorialLayout(
                        tutorialItem: element,
                        offsetWidget: offsetWidget,
                        sizeWidget: sizeWidget,
                        sizeScreen: sizeScreen,
                      )
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
