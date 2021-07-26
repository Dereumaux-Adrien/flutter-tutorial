import 'package:app_tutorial/src/models/space_division.dart';
import 'package:flutter/material.dart';
import 'package:app_tutorial/src/models/shape_models.dart';

class TutorialItems {
  final GlobalKey? globalKey;
  final ShapeFocus? shapeFocus;
  final List<Widget> children;
  final Widget? widgetNext;
  final Color? backgroundColor;
  final Radius? borderRadius;
  final int addedPadding;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool touchScreen;
  final SpaceDivision heightDivision;

  TutorialItems({
    this.globalKey,
    required this.children,
    this.shapeFocus,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.widgetNext,
    this.backgroundColor,
    this.borderRadius,
    this.addedPadding = 0,
    this.touchScreen = false,
    this.heightDivision = const SpaceDivision(),
  });
}
