import 'package:bike_ride/back%20end/services/services_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/offer.dart';
import '../values/firestore_collections.dart';

class OffersServices extends ServicesInterface {
  final String rentalDocumentId;

  OffersServices({
    required this.rentalDocumentId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(rentalsCollectionName)
                .doc(rentalDocumentId)
                .collection(offersCollectionName));

  List<Offer> getAll() => getAllDocs(collectionReference, Offer).cast<Offer>();

  List<Offer> withId(String id) => docsWithId(id, Offer).cast<Offer>();
}
