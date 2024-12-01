import 'package:bike_ride/back%20end/models/bike.dart';
import 'package:bike_ride/back%20end/services/_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import '../values/firestore_collections.dart';

class BikesServices extends Services {
  final String rentalDocumentId;

  BikesServices({
    required this.rentalDocumentId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(rentalsCollectionName)
                .doc(rentalDocumentId)
                .collection(bikesCollectionName));

  Future<List<Bike>> getAll() async {
  List ft = await getAllDocs(collectionReference, Bike);
  return ft.cast<Bike>();
}

  Future<List<Bike>> withId(String id) async {
    List ft = await docsWithId(id, Bike);
    return ft.cast<Bike>();
  }

  Future<List<Bike>> filterWith(String id, BikesFilter bikeFilter) async {
    Query query = collectionReference;

    for (Function(Query, BikesFilter) filter in [
      _pricePerHour,
      _bookingPrice,
      _bookDuration,
      _availabilityStatus,
    ]) {
      query = filter(query, bikeFilter);
    }

    List ft = await getAllDocs(query, Bike);

    return _rating(ft.cast<Bike>(), bikeFilter);
  }

  Query _pricePerHour(Query query, BikesFilter bikeFilter) {
    return query
        .where('pricePerHour', isGreaterThan: bikeFilter.lowerPriceLimit)
        .where('pricePerHour', isLessThan: bikeFilter.upperPriceLimit);
  }

  Query _bookingPrice(Query query, BikesFilter bikeFilter) {
    return query
        .where('bookingPrice', isGreaterThan: bikeFilter.lowerBookingPriceLimit)
        .where('bookingPrice', isLessThan: bikeFilter.upperBookingPriceLimit);
  }

  Query _bookDuration(Query query, BikesFilter bikeFilter) {
    return query
        .where('bookDuration', isGreaterThan: bikeFilter.lowestBookDuration)
        .where('bookDuration', isLessThan: bikeFilter.highestBookDuration);
  }

  Query _availabilityStatus(Query query, BikesFilter bikeFilter) {
    return query.where('availabilityStatus',
        isEqualTo: bikeFilter.availabilityStatus.name);
  }

  List<Bike> _rating(List<Bike> bikes, BikesFilter bikeFilter) {
    return bikes
        .where((bike) => bike.ratings.average > bikeFilter.lowestRating)
        .toList();
  }
}

class BikesFilter {
  int lowerPriceLimit,
      upperPriceLimit,
      lowerBookingPriceLimit,
      upperBookingPriceLimit,
      lowestBookDuration,
      highestBookDuration;
  AvailabilityStatus availabilityStatus;
  double lowestRating;

  BikesFilter({
    this.lowerPriceLimit = 0,
    this.upperPriceLimit = 1000,
    this.lowerBookingPriceLimit = 0,
    this.upperBookingPriceLimit = 1000,
    this.lowestBookDuration = 0,
    this.highestBookDuration = 1000,
    this.availabilityStatus = AvailabilityStatus.AVAILABLE,
    this.lowestRating = 0,
  });
}
