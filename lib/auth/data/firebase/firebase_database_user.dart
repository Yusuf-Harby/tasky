import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/core/network/firebase_result.dart';
import 'package:tasky/auth/data/model/user_model.dart';

class FBAUser {
  static CollectionReference<UserModel> get _getCollection {
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );
  }

  static Future<void> addUser(UserModel user) async {
    try {
      await _getCollection.doc(user.id).set(user);
    } catch (e) {
      throw "Error From added User $e";
    }
  }

  static Future<FBResult<UserModel>> registerUser(UserModel user) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email ?? '',
            password: user.password ?? '',
          );
      user.id = credential.user?.uid;
      await _getCollection.doc(user.id).set(user);
      return FBSuccess(data: user);
    } catch (e) {
      return FBError(message: e.toString());
    }
  }

  static Future<FBResult<UserCredential>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return FBSuccess(data: credential);
    } catch (e) {
      return FBError(message: e.toString());
    }
  }
}
