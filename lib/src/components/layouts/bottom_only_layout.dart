import 'package:flutter/material.dart';

class BottomOnlyLayout extends StatelessWidget {
  final List<Widget> children;

  final double positionHoleY;

  final double heightHole;

  const BottomOnlyLayout({
    Key? key,
    required this.children,
    required this.positionHoleY,
    required this.heightHole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: positionHoleY,
        ),
        SizedBox(
          height: heightHole,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ],
    );
  }
}
