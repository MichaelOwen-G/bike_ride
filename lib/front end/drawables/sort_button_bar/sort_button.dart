part of 'sort_button_bar.dart';

class SortButton extends StatefulWidget {
  final Text text;
  final Function(bool) sortFunc;
  final SortButtonBarController sortController;
  final int index;

  const SortButton({
    required this.index,
    required this.sortController,
    required this.text,
    required this.sortFunc,
    super.key,
  });

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  ValueNotifier<bool> ascending = ValueNotifier(true);
  ValueNotifier<bool> active = ValueNotifier(false);

  @override
  void initState() {
    listenForClick();
    widget.sortController.addListener(listenForClick);
    super.initState();
  }

  void listenForClick(){
    active.value = widget.sortController.activeButton == widget.index;
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;

      return GestureDetector(
          onTap: () => onClick(active.value),
          child: ValueListenableBuilder(
              valueListenable: active,
              builder: (BuildContext context, val, Widget? child) {
                return Container(
              height: height, color: Colors.transparent,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                widget.text,
                SizedBox(
                    height: height,
                    width: 20,
                    child: ValueListenableBuilder(
                        valueListenable: ascending,
                        builder: (context, val, child) {
                          return _orderIcons(active.value);
                        }))
              ])); }),
      );
    });
  }

  void onClick(bool active) {
    // if not first time pressed change order
    if (active) ascending.value = !ascending.value;

    // call sort func
    // widget.sortFunc(ascending.value);

    // change active button
    // notify listeners of button click
    widget.sortController.activeButton = widget.index;
  }

  Widget _orderIcons(active) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
      Icon(
        Icons.arrow_drop_up,
        size: active
            ? ascending.value
            ? 20
            : 14
            : 14,
        color: active
            ? ascending.value
                ? Colors.white
                : Colors.grey
            : Colors.grey.withAlpha(100),
      ),
      Icon(
        Icons.arrow_drop_down,
        size: active
            ? ascending.value
            ? 12
            : 18
            : 14,
        color: active
            ? ascending.value
                ? Colors.grey
                : Colors.white
            : Colors.grey.withAlpha(100),
      ),
    ]);
  }
}
