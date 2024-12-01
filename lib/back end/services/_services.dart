import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  CollectionReference collectionReference;

  Services({required this.collectionReference});

  Future<List> docsWithId(String id, var docType) async {
    List docs = [];

    await collectionReference.where('id', isEqualTo: id).get().then((snapShot) {
      for (var docShot in snapShot.docs) {
        docs.add(docType.fromMap(docShot as Map<String, dynamic>));
      }
    });

    return docs;
  }

  Future<List> getAllDocs(Query query, var docType, {bool asStream = false}) async {
    List docs = [];

    await query.get().then((snapShot) {
      for (var docSnapShot in snapShot.docs) {
        docs.add(docType.fromMap(docSnapShot as Map<String, dynamic>));
      }
    });

    return docs;
  }

  Stream getAllDocsStream(Query query, var docType) {
    /// returns a stream of objects converted to docType
    return query.get().asStream().map((snapShot) => snapShot.docs
        .map((doc) => docType.fromMap(doc as Map<String, dynamic>)));
  }

  // * =================== CRUD OPS =========================
  Future<Map<String, dynamic>> createDoc(Map<String, dynamic> docMap) async {
    var docLocation = collectionReference.doc();

    docMap['id'] = docLocation.id;

    await docLocation.set(docMap);

    return docMap;
  }

  Future<bool> updateDoc(String docId, Map<String, dynamic> docMap) async {
    try {
      await collectionReference.doc(docId).update(docMap);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteDoc(String id) async {
    try {
      await collectionReference.doc(id).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
