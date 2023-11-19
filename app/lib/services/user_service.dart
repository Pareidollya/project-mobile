import 'package:app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String user, String senha, String avatarIcon) async {
    DocumentReference docRef = _firestore.collection('users').doc();

    await docRef.set({
      'id': docRef.id,
      'user': user,
      'senha': senha,
      'avatar_icon': avatarIcon,
    });
  }

  Future<User> getUser(String id) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(id).get();

    return User(
      id: doc['id'],
      username: doc['user'],
      password: doc['senha'],
      avatarIcon: doc['avatar_icon'],
    );
  }

  Future<bool> getUserByUsername(String username) async {
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('user', isEqualTo: username)
        .get();

    if (query.docs.isEmpty) {
      return false;
    }

    return true;
  }

  Future<User> login(String username, String password) async {
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('user', isEqualTo: username)
        .where('senha', isEqualTo: password)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('Usuário ou senha inválidos');
    }

    DocumentSnapshot doc = query.docs.first;

    return User(
      id: doc['id'],
      username: doc['user'],
      password: doc['senha'],
      avatarIcon: doc['avatar_icon'],
    );
  }
 
}
