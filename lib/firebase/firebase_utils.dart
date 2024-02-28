import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';
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
  static Future<void> updateTasksInFireStorage(Task task) async {
    await FirebaseFirestore.instance.collection(Task.collectionName).doc(task.id).update(task.toFireStore());
  }
}
