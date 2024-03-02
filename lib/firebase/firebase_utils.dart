import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/user.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTasksToFireStorage(Task task) {
    var taskCollectionRef = getTasksCollection();
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id; // out id generated
    return taskDocRef.set(task);
  }

  static Future<void> deleteTasksFromFireStorage(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  // static Future<void> updateTaskOnFirestore(Task task) {
  //   var collectionRef = getTasksCollection();
  //   var docRef = collectionRef.doc(task.id);
  //   return docRef.update(task.toFireStore());
  // }
  static Future<void> updateTask(Task task) {
    return FirebaseUtils.getTasksCollection()
        .doc(task.id)
        .update({
          'title': task.title,
          'description': task.description,
        })
        .then((value) => print("User Updated successfully"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static CollectionReference<Users> getUser() {
    return FirebaseFirestore.instance
        .collection(Users.collectionName)
        .withConverter<Users>(
            fromFirestore: (snapshot, options) =>
                Users.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addUserToFireStorage(Users user) {
    return getUser().doc(user.id).set(user);
  }
}
