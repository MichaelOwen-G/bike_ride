import 'package:bike_ride/back%20end/services/services_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/rental.dart';
import '../values/firestore_collections.dart';

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class RentalsServices extends ServicesInterface {
  RentalsServices()
      : super(
            collectionReference:
                FirebaseFirestore.instance.collection(rentalsCollectionName));

  // * ================ FETCHING AND FILTERING =============================

  List<Rental> withId(String id) => docsWithId(id, Rental).cast<Rental>();

  List<Rental> filterWith(RentalsFilter rentalsFilter) {
    Query query = collectionReference;

    for (Function(Query, RentalsFilter) filter in [
      _pricePerHour,
      _open,
    ]) {
      query = filter(query, rentalsFilter);
    }

    return _rating(getAllDocs(query, Rental).cast<Rental>(), rentalsFilter);
  }

  // * find within price limits
  Query _pricePerHour(Query query, RentalsFilter rentalsFilter) {
    return query
        .where('pricePerHour', isGreaterThan: rentalsFilter.lowerPriceLimit)
        .where('pricePerHour', isLessThan: rentalsFilter.upperPriceLimit);
  }

  // * filter the open rentals
  Query _open(Query query, RentalsFilter rentalsFilter) {
    if (rentalsFilter.checkOpen == false) {
      return query;
    }

    return query
        .where('openingTime', isLessThan: rentalsFilter.timeToCheck)
        .where('closingTime', isGreaterThan: rentalsFilter.timeToCheck);
  }

  List<Rental> _rating(List<Rental> rentals, RentalsFilter rentalsFilter) {
    return rentals
        .where((rental) => rental.ratings.average > rentalsFilter.lowestRating)
        .toList();
  }

  // * ================== SORTING FETCHED =======================
  List<Rental> sortWithRating(List<Rental> rentals, {bool ascending = true}) {
    // sort
    rentals.sort((x, y) {
      return x.ratings.average.compareTo(y.ratings.average);
    });

    // ascending
    if (ascending) {
      return rentals.reversed.toList();
    }

    return rentals;
  }

  List<Rental> sortWithPricePerHour(List<Rental> rentals,
      {bool ascending = true}) {
    // sort
    rentals.sort((x, y) {
      return x.pricePerHour.compareTo(y.pricePerHour);
    });

    // ascending
    if (ascending) {
      return rentals.reversed.toList();
    }

    return rentals;
  }
}

class RentalsFilter {
  int lowerPriceLimit, upperPriceLimit;
  double lowestRating;
  bool checkOpen;
  final int? _timeToCheck;

  RentalsFilter({
    this.lowerPriceLimit = 0,
    this.upperPriceLimit = 1000,
    this.lowestRating = 0,
    this.checkOpen = false,
    timeToCheck,
  }) : _timeToCheck = timeToCheck;

  int get timeToCheck {
    if (_timeToCheck == null) {
      return double.parse(_getNowTimeIn24Hr()).toInt();
    }
    return _timeToCheck;
  }

  // get timestamp of now in 24 hr format
  String _getNowTimeIn24Hr() {
    return DateFormat('HHmm').format(DateTime.now());
  }
}
