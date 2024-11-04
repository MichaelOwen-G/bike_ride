
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesInterface {
  CollectionReference collectionReference;

  ServicesInterface({required this.collectionReference});


  List docsWithId(String id, var docType){
      List docs = [];

      collectionReference.where('id', isEqualTo: id).get().then((snapShot){
        for (var docShot in snapShot.docs){
          docs.add(docType.fromMap(docShot as Map<String, dynamic>));
        }
      });

      return docs;
    }

  List getAllDocs(Query query, var docType) {
    List docs = [];

    query.get().then((snapShot) {
      for (var docSnapShot in snapShot.docs) {
        docs.add(docType.fromMap(docSnapShot as Map<String, dynamic>));
      }
    });

    return docs;
  }


  // * =================== CRUD OPS =========================
  Map<String, dynamic> createDoc(Map<String, dynamic> docMap){
    var docLocation = collectionReference.doc();

    docMap['id'] = docLocation.id;

    docLocation.set(docMap);

    return docMap;
  }

  bool updateDoc(String docId, Map<String, dynamic> docMap){
    try {
      collectionReference.doc(docId).update(docMap);
      return true;
    }
    catch (e){
      log(e.toString());
      return false;
    }
  }

  bool deleteDoc(String id){
    try {
      collectionReference.doc(id).delete();
      return true;
    }
    catch (e){
      log(e.toString());
      return false;
    }
  }

}
