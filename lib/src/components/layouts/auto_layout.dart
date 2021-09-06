import 'package:flutter/material.dart';

class AutoLayout extends StatelessWidget {
  final List<Widget> children;

  final double positionHoleY;

  final double heightHole;

  final Size sizeScreen;

  const AutoLayout({
    Key? key,
    required this.children,
    required this.positionHoleY,
    required this.heightHole,
    required this.sizeScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ratio =
        ((positionHoleY * children.length) / (sizeScreen.height - heightHole))
            .floor();
    var childrenTop = children.getRange(0, ratio).toList();
    var childrenBottom =
        children.getRange(ratio, children.length - 1).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
