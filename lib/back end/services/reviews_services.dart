import 'package:bike_ride/back%20end/models/review.dart';
import 'package:bike_ride/back%20end/services/_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../values/firestore_collections.dart';

class ReviewsServices extends Services {
  final String rentalDocumentId;
  final String bikeDocumentId;

  ReviewsServices({
    required this.rentalDocumentId,
    required this.bikeDocumentId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(rentalsCollectionName)
                .doc(rentalDocumentId)
                .collection(bikesCollectionName)
                .doc(bikeDocumentId)
                .collection(reviewsCollectionName));

  Future<List<Review>> getAll() async {
    List ft = await getAllDocs(collectionReference, Review);

    return ft.cast<Review>();
  }

  Future<List<Review>> withId(String id) async {
    List ft = await docsWithId(id, Review);
    return ft.cast<Review>();
  }
}
