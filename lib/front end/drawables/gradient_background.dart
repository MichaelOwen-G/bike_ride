import 'package:flutter/material.dart';

import '../values/colors.dart';

class MyGradientBackground extends StatelessWidget {
  final bool darkMode;
  final Widget? child;
  const MyGradientBackground({this.darkMode = true, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (widget, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const <double>[
              .6,
              1,
            ],
            colors: darkMode
                ? [
                    Colors.black.withAlpha(170),
                    Colors.black12,
                  ]
                : [
                    silver,
                    white,
                  ],
          ),
        ),
        child: child,
      );
    });
  }
}
