import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/auth/data/model/user_model.dart';
import 'package:tasky/core/network/firebase_result.dart';
import 'package:tasky/home/data/model/task_model.dart';

abstract class FBTask {
  static CollectionReference<TaskModel> get _getCollection {
    final userToken = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        )
        .doc(userToken)
        .collection(TaskModel.collection)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<FBResult<void>> addTask(TaskModel task) async {
    try {
      final doc = _getCollection.doc();
      task.id = doc.id;
      await doc.set(task);
      return FBSuccess();
    } catch (e) {
      return FBError(message: e.toString());
    }
  }
}
