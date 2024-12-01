import 'package:bike_ride/back%20end/services/_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../values/firestore_collections.dart';

class UsersServices extends Services {

  UsersServices(): super(collectionReference: FirebaseFirestore.instance.collection(usersCollectionName));

  Future<User> createUser (User user) async {
    Map<String, dynamic> newUserMap = await createDoc(user.toMap());

    return User.fromMap(newUserMap);
  }

  Future<List<User>> withId(String id) async {
    List ft = await docsWithId(id, User);
    return ft.cast<User>();
  }

  Future<List<User>> ofUId(String uId) async {
    List ft = await getAllDocs(collectionReference.where('userId', isEqualTo: uId), User);
    return ft.cast<User>();
  }

}