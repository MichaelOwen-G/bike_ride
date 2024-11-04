part of 'home_screen.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  void toFilterPage() {}
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // * top part
      Expanded(
        flex: 2,
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const BikeRideLogo(),
          IconButton(
              onPressed: toFilterPage,
              icon:
                  const Icon(Icons.filter_list, color: Colors.white, size: 22))
        ]),
      )),

      // * bottom part
      Expanded(
        flex: 3,
        child: Row(children: [
          Expanded(
              flex: 4,
              child: Container()),
          Expanded(
            flex: 3,
              child: const CyclistAccountButton()),
          Expanded(
              flex: 4,
              child: Container(
              )),
        ]),
      )
    ]);
  }
}
