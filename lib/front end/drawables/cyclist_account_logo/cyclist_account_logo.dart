import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../back end/models/user.dart';
import '../../providers/backend_providers/current_user_provider.dart';
import '../../values/colors.dart';
import '../../values/images.dart';

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
    User? user = Provider.of<CurrentUserProvider>(context).user;

    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;

      double normalRadius = maxWidth / 2;

      posX = (maxWidth / 2) -
          (normalRadius / 2); // place the avatar at the center of parent

      Timer.run(() => posY = (maxHeight / 2) -
          (normalRadius / 2)); // animate down on next frame to kickstart anim

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
                child: _logo(normalRadius, disabled: user == null))
          ]));
    });
  }

  Widget _logo(double radius, {required bool disabled}) {
    double iconsPadding = 12;

    return Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
            color: disabled ? Colors.redAccent : Colors.grey,
            boxShadow: kElevationToShadow[8],
            borderRadius: BorderRadius.circular(radius / 2)),
        child: Stack(children: [
          // logo
          Padding(
              padding: EdgeInsets.all(iconsPadding),
              child: disabled
                    ? Container(alignment: Alignment.center, child: Icon(
                Icons.wifi_off_outlined,
                size: radius / 2,
                color: Colors.black,
              ),)
                    : Image.asset(helmet, fit: BoxFit.fitWidth),
              ),

        ]));
  }
}
