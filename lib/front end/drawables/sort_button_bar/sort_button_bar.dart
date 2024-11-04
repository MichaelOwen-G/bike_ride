import 'package:flutter/material.dart';

part 'sort_button.dart';

class SortButtonBar extends StatefulWidget {
  final List<SortButton> sortButtons;
  final EdgeInsets padding;
   const SortButtonBar(this.sortButtons,
      {this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      super.key});

  @override
  State<SortButtonBar> createState() => _SortButtonBarState();
}

class _SortButtonBarState extends State<SortButtonBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;

      return  Container(
              padding: widget.padding,
              height: height,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.sortButtons,
              ),
            );

    });
  }
}

class SortButtonBarController extends ChangeNotifier {
  int _activeButton;

  SortButtonBarController({
    int activeButton = 0,
  }) : _activeButton = activeButton;

  set activeButton(int newIndex) {
    _activeButton = newIndex;
    notifyListeners();
  }

  int get activeButton => _activeButton;
}
