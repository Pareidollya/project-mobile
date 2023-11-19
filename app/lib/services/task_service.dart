import 'package:app/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTask(Task task) async {
    DocumentReference docRef = _firestore.collection('tasks').doc();
    await docRef.set({
      'id': docRef.id,
      'title': task.title,
      'date': task.date,
      'status': task.status,
      'completed': task.completed,
      'user_id': task.userId,
    });
  }

  Future<List<Task>> getTasks(String userId) async {
    QuerySnapshot query = await _firestore
        .collection('tasks')
        .where('user_id', isEqualTo: userId)
        .get();

    if (query.docs.isEmpty) {
      return [];
    } else {
      return query.docs.map((doc) {
        return Task(
          id: doc['id'],
          title: doc['title'],
          date: doc['date'],
          status: doc['status'],
          completed: doc['completed'],
          userId: doc['user_id'],
        );
      }).toList();
    }
  }

  Future<Task> getTaskById(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection('tasks').doc(id).get();
    return Task(
      id: doc['id'],
      title: doc['title'],
      date: doc['date'],
      status: doc['status'],
      completed: doc['completed'],
      userId: doc['user_id'],
    );
  }

  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update({
      'title': task.title,
      'date': task.date,
      'status': task.status,
      'completed': task.completed,
    });
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }


}