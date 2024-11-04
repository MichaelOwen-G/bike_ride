import 'package:bike_ride/back%20end/models/review.dart';
import 'package:bike_ride/back%20end/services/services_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../values/firestore_collections.dart';

class ReviewsServices extends ServicesInterface {
  final String rentalDocumentId;
  final String bikeDocumentId;

  ReviewsServices({
    required this.rentalDocumentId,
    required this.bikeDocumentId,
  }) : super(collectionReference: FirebaseFirestore.instance
            .collection(rentalsCollectionName)
            .doc(rentalDocumentId)
            .collection(bikesCollectionName)
            .doc(bikeDocumentId)
            .collection(reviewsCollectionName));

  List<Review> getAll() => getAllDocs(collectionReference, Review).cast<Review>();

  List<Review> withId(String id) => docsWithId(id, Review).cast<Review>();
}
