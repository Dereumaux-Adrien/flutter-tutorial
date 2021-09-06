import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final List<Widget> children;

  const DefaultLayout({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
