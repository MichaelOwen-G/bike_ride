import 'dart:async';

import 'package:flutter/material.dart';

import '../values/colors.dart';
import '../values/images.dart';

class CyclistAccountButton extends StatefulWidget {
  const CyclistAccountButton({super.key});

  @override
  State<CyclistAccountButton> createState() => _CyclistAccountButtonState();
}

class _CyclistAccountButtonState extends State<CyclistAccountButton> {
  double posX = 0;
  double posY = 0;

  bool moveDown = true;

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;

      double circleRadius = maxWidth / 2;

      posX = (maxWidth / 2) -
          (circleRadius / 2); // place the avatar at the center of parent


      Timer.run(() => posY = (maxHeight / 2) - (circleRadius / 2));

      return Container(
          height: maxHeight,
          width: maxWidth,
          child: Stack(children: [
            AnimatedPositioned(
                left: posX,
                top: posY,
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutQuad,
                onEnd: () {
                  setState(() {
                    posY = moveDown ? posY + 1.5 : posY - 1.5;
                    moveDown = !moveDown;
                  });
                },
                child: Container(
                    height: circleRadius,
                    width: circleRadius,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        boxShadow: kElevationToShadow[8],
                        borderRadius: BorderRadius.circular(circleRadius / 2)),
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(helmet,
                            fit: BoxFit.fitWidth))))
          ]));
    });
  }
}
