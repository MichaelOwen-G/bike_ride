part of 'home_screen.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  TextEditingController textEditingController = TextEditingController();

  final double _searchFontSize = 14;

  ValueNotifier<List<Rental>> rentalsFoundNotifier = ValueNotifier(<Rental>[]);

  SortButtonBarController sortButtonBarController = SortButtonBarController();

  void searchQuery(String _) {
    // get query
    String query = textEditingController.text;
  }

  void sortByPrice(bool ascending) {
    /// sort by price
    rentalsFoundNotifier.value = RentalsServices().sortWithPricePerHour(
      rentalsFoundNotifier.value,
      ascending: ascending,
    );
  }

  void sortByLocation(bool ascending) {}

  void sortByRating(bool ascending) {
    rentalsFoundNotifier.value = RentalsServices().sortWithRating(
      rentalsFoundNotifier.value,
      ascending: ascending,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // search bar
      Expanded(child: _searchBar()),

      // sort bar
      Expanded(child: _sortBar()),

      // content
      Expanded(flex: 14, child: Container(color: Colors.white,))
    ]);
  }

  Widget _sortBar() {
    TextStyle style = const TextStyle(color: Colors.white, fontSize: 10);
    return SortButtonBar(
      [
        SortButton(
            index: 0,
            sortController: sortButtonBarController,
            text: Text(
              'Price',
              style: style,
            ),
            sortFunc: sortByPrice),
        SortButton(
            index: 1,
            sortController: sortButtonBarController,
            text: Text('Location', style: style),
            sortFunc: sortByLocation),
        SortButton(
            index: 2,
            sortController: sortButtonBarController,
            text: Text('Rating', style: style),
            sortFunc: sortByRating),
      ],
      padding: const EdgeInsets.symmetric(horizontal: 38),
    );
  }

  Widget _searchBar() {
    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth / 1.3;
      double borderRadius = 6;

      return Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            // Text Input a quarter of search bar
            Expanded(
                flex: 4,
                child: TextField(
                  controller: textEditingController,
                  onChanged: searchQuery,
                  style: TextStyle(fontSize: _searchFontSize),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: 'Search Rental',
                      hintStyle: TextStyle(
                          color: Colors.grey.withAlpha(180),
                          fontSize: _searchFontSize),
                      contentPadding:
                          const EdgeInsets.only(left: 12, right: 8, bottom: 4),
                      border: InputBorder.none),
                )),
            Expanded(
                child: IconButton(
              onPressed: () {},
              iconSize: 20,
              icon: const Icon(Icons.search),
            )),
          ],
        ),
      );
    });
  }
}
