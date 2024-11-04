import 'package:bike_ride/back%20end/services/services_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../values/firestore_collections.dart';

class UsersServices extends ServicesInterface {

  UsersServices(): super(collectionReference: FirebaseFirestore.instance.collection(usersCollectionName));

  List<User> withId(String id) => docsWithId(id, User).cast<User>();

}