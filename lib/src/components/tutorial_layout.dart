import 'package:app_tutorial/src/models/children_layout.dart';
import 'package:app_tutorial/src/models/tutorial_item.dart';
import 'package:flutter/material.dart';

class TutorialLayout extends StatelessWidget {
  final TutorialItem tutorialItem;

  final Size sizeScreen;

  final Offset offsetWidget;

  final Size sizeWidget;

  const TutorialLayout({
    Key? key,
    required this.tutorialItem,
    required this.sizeScreen,
    required this.offsetWidget,
    required this.sizeWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dy = offsetWidget.dy +
        (sizeWidget.height / 2) -
        tutorialItem.extraPadding.top;
    var height = sizeWidget.height +
        tutorialItem.extraPadding.top +
        tutorialItem.extraPadding.bottom;
    var children = <Widget>[];
    switch (tutorialItem.childrenLayout) {
      case ChildrenLayout.bottom:
        children = [
          SizedBox(
            height: dy,
          ),
          SizedBox(
            height: height,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tutorialItem.children,
            ),
          ),
        ];
        break;
      case ChildrenLayout.top:
        children = [
          SizedBox(
            height: dy,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tutorialItem.children,
            ),
          ),
          SizedBox(
            height: height,
          ),
        ];
        break;
      case ChildrenLayout.auto:
        var ratio =
            ((dy * tutorialItem.children.length) / (sizeWidget.height - height))
                .floor();
        var childrenTop = tutorialItem.children.getRange(0, ratio).toList();
        var childrenBottom = tutorialItem.children
            .getRange(ratio, tutorialItem.children.length - 1)
            .toList();
        children = [
          SizedBox(
            height: dy,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: childrenTop,
            ),
          ),
          SizedBox(
            height: height,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: childrenBottom,
            ),
          ),
        ];
        break;
      default: // includes ChildrenLayout.none
        children = tutorialItem.children;
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: children,
      ),
    );
  }
}
