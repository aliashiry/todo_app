import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/user.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTasksToFireStorage(Task task, String uId) {
    var taskCollectionRef = getTasksCollection(uId);
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id; // out id generated
    return taskDocRef.set(task);
  }

  static Future<void> deleteTasksFromFireStorage(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateTask(Task task, String uId) {
    return FirebaseUtils.getTasksCollection(uId)
        .doc(task.id)
        .update({
          'title': task.title,
          'description': task.description,
        })
        .then((value) => print("User Updated successfully"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (task, _) => task.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUserCollection().doc(uId).get();
    return querySnapShot.data();
  }
}
