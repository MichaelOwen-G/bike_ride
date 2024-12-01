import 'package:flutter/material.dart';

class MaskedContentAnimation extends StatefulWidget {
  final Widget content;
  final List<Color> colors;
  final Duration duration;

  const MaskedContentAnimation(
      {required this.content,
      this.colors = const [Colors.grey, Colors.grey],
      this.duration = const Duration(milliseconds: 1000),
      super.key}): assert (colors.length > 1, "colors must be greater than two");

  @override
  State<MaskedContentAnimation> createState() => _MaskedContentAnimationState();
}

class _MaskedContentAnimationState extends State<MaskedContentAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
        vsync: this, duration: widget.duration);

    animationOne = ColorTween(begin: widget.colors[0], end: widget.colors[1])
        .animate(_animController);
    animationTwo = ColorTween(begin: widget.colors[1], end: widget.colors[0])
        .animate(_animController);

    _animController.forward();

    _animController.addListener(() {
      if (_animController.isCompleted) {
        _animController.reverse();
      }
      if (_animController.isDismissed) {
        _animController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (rect) => LinearGradient(colors: [
              animationOne.value!,
              animationTwo.value!,
            ]).createShader(rect),
        child: Container(child: widget.content));
  }
}
