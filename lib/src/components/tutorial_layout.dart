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
    var positionHoleY = offsetWidget.dy +
        (sizeWidget.height / 2) -
        tutorialItem.extraPadding.top;
    var heightHole = sizeWidget.height +
        tutorialItem.extraPadding.top +
        tutorialItem.extraPadding.bottom;
    var children = <Widget>[];
    switch (tutorialItem.childrenLayout) {
      case ChildrenLayout.bottom:
        children = [
          SizedBox(
            height: positionHoleY,
          ),
          SizedBox(
            height: heightHole,
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
            height: positionHoleY,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tutorialItem.children,
            ),
          ),
          SizedBox(
            height: heightHole,
          ),
        ];
        break;
      case ChildrenLayout.auto:
        var childrenLength = tutorialItem.children.length;
        if (childrenLength > 1) {
          var ratio = ((positionHoleY * childrenLength) /
                  (sizeScreen.height - heightHole))
              .floor();
          var childrenTop = tutorialItem.children.getRange(0, ratio).toList();
          var childrenBottom = tutorialItem.children
              .getRange(ratio, childrenLength - 1)
              .toList();
          children = [
            SizedBox(
              height: positionHoleY,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: childrenTop,
              ),
            ),
            SizedBox(
              height: heightHole,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: childrenBottom,
              ),
            ),
          ];
        } else {
          if (positionHoleY > sizeScreen.height - heightHole - positionHoleY)
            // If the space is bigger above the hole
            children = [
              SizedBox(
                height: positionHoleY,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: tutorialItem.children,
                ),
              ),
              SizedBox(
                height: heightHole,
              ),
            ];
          else
            // If the space is bigger under of the hole
            children = [
              SizedBox(
                height: positionHoleY,
              ),
              SizedBox(
                height: heightHole,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: tutorialItem.children,
                ),
              ),
            ];
        }
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
