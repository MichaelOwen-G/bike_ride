import 'package:bike_ride/back%20end/models/bike_book.dart';
import 'package:bike_ride/back%20end/services/services_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../values/firestore_collections.dart';

class BikeBookingsServices extends ServicesInterface {
  final String userId;

  BikeBookingsServices({
    required this.userId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(usersCollectionName)
                .doc(userId)
                .collection(bikeBookingsCollectionName));

  List<BikeBook> getAll() =>
      getAllDocs(collectionReference, BikeBook).cast<BikeBook>();

  List<BikeBook> withId(String id) => docsWithId(id, BikeBook).cast<BikeBook>();

  List<BikeBook> filterWith(String bikeId, bool active) {
    return getAllDocs(
      collectionReference
          .where('bikeId', isEqualTo: bikeId)
          .where('active', isEqualTo: active),
      BikeBook,
    ).cast<BikeBook>();
  }
}
