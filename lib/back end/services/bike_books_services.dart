import 'package:bike_ride/back%20end/models/bike_book.dart';
import 'package:bike_ride/back%20end/services/_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../values/firestore_collections.dart';

class BikeBookingsServices extends Services {
  final String userId;

  BikeBookingsServices({
    required this.userId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(usersCollectionName)
                .doc(userId)
                .collection(bikeBookingsCollectionName));

  Future<List<BikeBook>> getAll() async {
    List ft = await getAllDocs(collectionReference, BikeBook);
    return ft.cast<BikeBook>();
  }

  Stream<BikeBook> getAllStream() =>
      getAllDocsStream(collectionReference, BikeBook).cast<BikeBook>();

  Future<List<BikeBook>> withId(String id) async {
    List ft = await docsWithId(id, BikeBook);
    return ft.cast<BikeBook>();
  }

  Future<List<BikeBook>> filterWith(String bikeId, bool active) async {
    List ft = await getAllDocs(
      collectionReference
          .where('bikeId', isEqualTo: bikeId)
          .where('active', isEqualTo: active),
      BikeBook,
    );

    return ft.cast<BikeBook>();
  }
}
