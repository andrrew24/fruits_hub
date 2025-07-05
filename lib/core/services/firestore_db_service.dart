import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_hub/core/services/database_service.dart';

class FirestoreDatabaseService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? uid,
  }) async {
    if (uid != null) {
      await firestore.collection(path).doc(uid).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    String? uid,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection(path)
        .doc(uid)
        .get();

    if (snapshot.exists) {
      log("Document data: ${snapshot.data()}");
      return snapshot.data()!;
    } else {
      throw Exception('Document does not exist');
    }
  }

  @override
  Future<void> deleteUserData({
    required String path,
    required String uid,
  }) async {
    await firestore.collection(path).doc(uid).delete();
    log("Document with uid: $uid deleted from path: $path");
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String uid,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection(path)
        .doc(uid)
        .get();

    return snapshot.exists;
  }
}
