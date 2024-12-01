import 'package:bike_ride/back%20end/services/_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/offer.dart';
import '../values/firestore_collections.dart';

class OffersServices extends Services {
  final String rentalDocumentId;

  OffersServices({
    required this.rentalDocumentId,
  }) : super(
            collectionReference: FirebaseFirestore.instance
                .collection(rentalsCollectionName)
                .doc(rentalDocumentId)
                .collection(offersCollectionName));

  Future<List<Offer>> getAll() async {
   List ft =  await getAllDocs(collectionReference, Offer);
   return ft.cast<Offer>();
  }

  Future<List<Offer>> withId(String id) async {
    List ft = await docsWithId(id, Offer);
    return ft.cast<Offer>();
}
}
