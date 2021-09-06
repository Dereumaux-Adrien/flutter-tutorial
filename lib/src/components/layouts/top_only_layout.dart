import 'package:flutter/material.dart';

class TopOnlyLayout extends StatelessWidget {
  final List<Widget> children;

  final double positionHoleY;

  const TopOnlyLayout({
    Key? key,
    required this.children,
    required this.positionHoleY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: positionHoleY,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ],
    );
  }
}
