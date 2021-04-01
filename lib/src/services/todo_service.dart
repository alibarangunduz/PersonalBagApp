import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybagapp/src/models/todo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;
  //Get Entries
  Stream<List<Todo>> getEntries(){
    return _db
        .collection('Users')
        .doc(uid)
        .collection('Todos')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromJson(doc.data()))
        .toList());
  }

  //Upsert
  Future<void> setTodo(Todo todo){
    var options = SetOptions(merge:true);

    return _db
        .collection('Users')
        .doc(uid)
        .collection('Todos')
        .doc(todo.todoId)
        .set(todo.toMap(),options);
  }

  //Delete
  Future<void> removeTodo(String todoId){
    return _db
        .collection('Users')
        .doc(uid)
        .collection('Todos')
        .doc(todoId)
        .delete();
  }

}