import 'package:app_tutorial/src/models/children_layout.dart';
import 'package:flutter/material.dart';
import 'package:app_tutorial/src/models/shape_models.dart';

class TutorialItem {
  final GlobalKey? globalKey;
  final ShapeFocus? shapeFocus;
  final ChildrenLayout childrenLayout;
  final List<Widget> children;
  final Widget? widgetNext;
  final Color? backgroundColor;
  final Radius? borderRadius;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool touchScreen;
  final Function()? onNext;

  TutorialItem({
    this.globalKey,
    required this.children,
    this.childrenLayout = ChildrenLayout.none,
    this.shapeFocus,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.widgetNext,
    this.backgroundColor,
    this.borderRadius,
    this.touchScreen = false,
    this.onNext,
  });
}
