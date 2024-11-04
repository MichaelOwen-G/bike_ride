import 'package:flutter/material.dart';

import '../../values/text.dart';

class BikeRideLogo extends StatelessWidget {
  const BikeRideLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 18),
      child: RichText(
          text:  TextSpan(style: const TextStyle(fontSize: 16), children: [
            TextSpan(
              text: bike,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'LexendPeta',
              ),
            ),
            TextSpan(
              text: ride,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'LexendPeta',
              ),
            )
          ])),
    );
  }
}
