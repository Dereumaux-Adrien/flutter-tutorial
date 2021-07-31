library tutorial;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app_tutorial/src/models/tutorial_items.dart';
import 'package:app_tutorial/src/painter/painter.dart';

class Tutorial {
  static Future<void> showTutorial(
    BuildContext context,
    List<TutorialItems> children,
  ) async {
    int count = 0;
    var size = MediaQuery.of(context).size;
    OverlayState overlayState = Overlay.of(context)!;
    List<OverlayEntry> entries = [];

    /// Completer is used to make this function a real Future that can be
    /// checked to allow for an execution to take place after the Tutorial
    var completer = new Completer<void>();

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
                        } else {
                          completer.complete();
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
                          width: sizeWidget.width + element.addedPadding,
                          height: sizeWidget.height + element.addedPadding,
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
                                flex: element.heightDivision.topSpace,
                                child: Container(),
                              ),
                              Expanded(
                                flex: element.heightDivision.textSpace,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: element.children,
                                ),
                              ),
                              Expanded(
                                flex: element.heightDivision.middleSpace,
                                child: Container(),
                              ),
                              Expanded(
                                flex: element.heightDivision.nextSpace,
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
                                    } else {
                                      completer.complete();
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: element.heightDivision.bottomSpace,
                                child: Container(),
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
    return completer.future;
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
