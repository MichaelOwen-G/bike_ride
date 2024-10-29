import 'package:flutter/material.dart';

import '../values/colors.dart';

class MyGradientBackground extends StatelessWidget {
  final bool darkMode;
  const MyGradientBackground({this.darkMode  = true, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (widget, constraints){
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: darkMode ? [
                silver,
                black,
              ] : [
                white,
                silver,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      );
    });

  }
}
