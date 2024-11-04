import 'package:bike_ride/back%20end/models/bike.dart';
import 'package:bike_ride/back%20end/services/services_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import '../values/firestore_collections.dart';

class BikesServices extends ServicesInterface {
  final String rentalDocumentId;

  BikesServices({
    required this.rentalDocumentId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(rentalsCollectionName)
                .doc(rentalDocumentId)
                .collection(bikesCollectionName));

  List<Bike> getAll() => getAllDocs(collectionReference, Bike).cast<Bike>();

  List<Bike> withId(String id) => docsWithId(id, Bike).cast<Bike>();

  List<Bike> filterWith(String id, BikesFilter bikeFilter) {
    Query query = collectionReference;

    for (Function(Query, BikesFilter) filter in [
      _pricePerHour,
      _bookingPrice,
      _bookDuration,
      _availabilityStatus,
    ]) {
      query = filter(query, bikeFilter);
    }

    return _rating(getAllDocs(query, Bike).cast<Bike>(), bikeFilter);
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
