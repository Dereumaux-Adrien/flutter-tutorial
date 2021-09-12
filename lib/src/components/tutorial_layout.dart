import 'package:app_tutorial/app_tutorial.dart';
import 'package:app_tutorial/src/models/children_layout.dart';
import 'package:app_tutorial/src/models/tutorial_item.dart';
import 'package:flutter/material.dart';

import 'layouts/layouts.dart';

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
    var positionHoleY = offsetWidget.dy - tutorialItem.extraPadding.top;
    var heightHole = sizeWidget.height +
        tutorialItem.extraPadding.top +
        tutorialItem.extraPadding.bottom;
    StatelessWidget layout;
    if (tutorialItem.shapeFocus == ShapeFocus.noFocus)
      layout = DefaultLayout(
        children: tutorialItem.children,
      );
    else {
      switch (tutorialItem.childrenLayout) {
        case ChildrenLayout.bottom:
          layout = BottomOnlyLayout(
            children: tutorialItem.children,
            positionHoleY: positionHoleY,
            heightHole: heightHole,
          );
          break;
        case ChildrenLayout.top:
          layout = TopOnlyLayout(
            children: tutorialItem.children,
            positionHoleY: positionHoleY,
          );
          break;
        case ChildrenLayout.auto:
          var childrenLength = tutorialItem.children.length;
          if (childrenLength > 1) {
            layout = AutoLayout(
              children: tutorialItem.children,
              positionHoleY: positionHoleY,
              heightHole: heightHole,
              sizeScreen: sizeScreen,
            );
          } else {
            if (positionHoleY >
                sizeScreen.height - (heightHole + positionHoleY)) {
              // If the space is bigger above the hole
              layout = TopOnlyLayout(
                children: tutorialItem.children,
                positionHoleY: positionHoleY,
              );
            } else {
              // If the space is bigger under of the hole
              layout = BottomOnlyLayout(
                children: tutorialItem.children,
                positionHoleY: positionHoleY,
                heightHole: heightHole,
              );
            }
          }
          break;
        default: // includes ChildrenLayout.none
          layout = DefaultLayout(
            children: tutorialItem.children,
          );
          break;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: layout,
    );
  }
}
